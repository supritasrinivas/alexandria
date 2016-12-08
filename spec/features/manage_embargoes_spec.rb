require "rails_helper"

feature "Embargo management:" do
  before do
    # To make it easier to interact with the form during the
    # specs, make sure we don't have other embargoed records
    # in the table.
    ETD.destroy_all
    Image.destroy_all
  end

  let!(:etd) do
    create(:etd,
           admin_policy_id: AdminPolicy::DISCOVERY_POLICY_ID,
           embargo_release_date: old_date,
           visibility_during_embargo: RDF::URI(ActiveFedora::Base.id_to_uri(AdminPolicy::DISCOVERY_POLICY_ID)),
           visibility_after_embargo: RDF::URI(ActiveFedora::Base.id_to_uri(old_policy_id))
          )
  end

  let(:old_date) { Date.today + 7.days }
  let(:new_date) { Date.today + 14.days }

  let(:old_policy_id) { AdminPolicy::PUBLIC_POLICY_ID }
  let(:new_policy) { Hydra::AdminPolicy.find(AdminPolicy::UCSB_POLICY_ID) }

  # Make sure it still works if the ETD has a file attached.
  let!(:fs) do
    fs = create(:file_set,
                admin_policy_id: AdminPolicy::DISCOVERY_POLICY_ID)
    Hydra::Works::AddFileToFileSet.call(fs, file, :original_file)
    EmbargoService.copy_embargo(etd, fs)
    etd.ordered_members << fs
    etd.save!
    fs.save!
    fs
  end
  let(:file) { File.new(fixture_file_path("pdf/sample.pdf")) }

  context "a rights-admin user" do
    let(:rights_admin) { create(:rights_admin) }
    before { login_as(rights_admin) }

    context "for an active embargo:" do
      scenario "edits the embargo" do
        # Navigate to the edit form for this embargo
        visit search_catalog_path
        click_link "Embargoes"
        click_link etd.title.first

        # Edit the embargo
        fill_in "until", with: new_date
        select new_policy.title, from: "Visibility after embargo"
        click_on "Save Changes"

        # Find the correct row in the table for this embargo,
        # and check for the expected new values.
        click_link "Embargoes"
        within(:xpath, ".//tr[td[a[contains(., etd.title.first)]]]") do
          expect(page).to have_css "td.embargo-release-date", text: new_date.to_s
          expect(page).to have_css "td.visibility-after-embargo", text: new_policy.title
        end
      end
    end

    context "for an active embargo that has expired:" do
      let(:old_date) { Date.today - 3.days }

      scenario "deactivates the embargo for the ETD, but not for the attached file" do
        # The ETD starts with "Discovery" access
        visit catalog_ark_path("ark:", "99999", etd.id)
        expect(page).to have_content "Access: Discovery access only"

        visit embargoes_path
        click_link "Expired Active Embargoes"

        # Check the checkbox for this ETD
        find(:css, "#batch_document_#{etd.id}").set(true)

        # Find the checkbox for attached files, and uncheck it
        files_checkbox = find(:xpath, ".//td[contains(., 'Change all files')]/input")
        files_checkbox.set(false)

        click_button "Deactivate Embargo"

        # The ETD now has "Public" access
        visit catalog_ark_path("ark:", "99999", etd.id)
        expect(page).to have_content "Access: Public access"

        # The access for the attached file shouldn't change
        expect(fs.reload.admin_policy_id).to eq AdminPolicy::DISCOVERY_POLICY_ID
      end

      scenario "deactivates the embargo for both the ETD and the attached file" do
        visit embargoes_path
        click_link "Expired Active Embargoes"

        # Check the checkbox for this ETD
        find(:css, "#batch_document_#{etd.id}").set(true)

        # Find the checkbox for attached files, and check it
        files_checkbox = find(:xpath, ".//td[contains(., 'Change all files')]/input")
        files_checkbox.set(true)

        click_button "Deactivate Embargo"

        # The ETD now has "Public" access
        visit catalog_ark_path("ark:", "99999", etd.id)
        expect(page).to have_content "Access: Public access"

        # The attached file should also have "Public" access
        expect(fs.reload.admin_policy_id).to eq AdminPolicy::PUBLIC_POLICY_ID

        visit embargoes_path
        click_link "Deactivated Embargoes"
        expect(page).to have_content "#{etd.title.first} Public access An expired embargo was deactivated"
        expect(page).to have_content "Visibility during embargo was Discovery access only and intended visibility after embargo was Public access"
      end
    end # context "for an active embargo that has expired:"
  end # context "a rights-admin user"
end
