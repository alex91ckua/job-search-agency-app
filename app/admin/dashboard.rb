ActiveAdmin.register_page "Dashboard" do

  menu priority: 1, label: proc{ I18n.t("active_admin.dashboard") }

  content title: proc{ I18n.t("active_admin.dashboard") } do
    # div class: "blank_slate_container", id: "dashboard_default_message" do
    #   span class: "blank_slate" do
    #     span I18n.t("active_admin.dashboard_welcome.welcome")
    #     small I18n.t("active_admin.dashboard_welcome.call_to_action")
    #   end
    # end

    # Here is an example of a simple dashboard with columns and panels.
    #
    columns do
      column do
        panel 'Recent Candidates' do

          table_for Candidate.order(created_at: :desc).limit(10) do
            column :id
            column :first_name
            column :last_name
            column :email
            column :job
            column ('Received At') { |candidate| time_ago_in_words(candidate.created_at) }
            column ('') { |candidate| link_to('View', admin_candidate_path(candidate)) }
          end

        end
      end

      column do
        panel 'Recent Jobs' do

          table_for Job.order(created_at: :desc).limit(10) do
            column :id
            column :title
            column (:created_at) { |job| time_ago_in_words(job.created_at) }
            column ('') { |job| link_to('View', admin_job_path(job)) }
          end

        end
      end
    end

  end # content
end
