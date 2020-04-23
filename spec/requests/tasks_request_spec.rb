require 'rails_helper'

RSpec.describe "Tasks", type: :request do
  describe 'email notifications' do
    before(:example) do
      sign_in(create(:user))
      ActionMailer::Base.deliveries.clear
    end
    let(:project) { create(:project) }
    let(:task) { create(:task, project: project, title: 'Learn how to test mailers', size: 3) }

    it 'does not send email when a task is not completed' do
      patch(task_path(id: task.id), params: { task: { completed: false } })
      expect(ActionMailer::Base.deliveries.size).to eq(0)
    end

    it "sends email when task is completed" do
      patch(task_path(id: task.id), params: {task: {completed: true}})
      expect(ActionMailer::Base.deliveries.size).to eq(1)
      email = ActionMailer::Base.deliveries.first
      expect(email.subject).to eq("A task has been completed")
      expect(email.to).to eq(["monitor@tasks.com"])
      expect(email.body.to_s).to match(/Learn how to test mailers/)
    end
  end

  describe 'task controller requests' do
    let!(:project) { create(:project, name: 'Project Bluebook') }
    let!(:user) { create(:user) }

    context 'creation' do
      before(:example) do
        sign_in(user)
      end

      it 'can create a task for project', :js do
        Role.create(project: project, user: user)
        post(tasks_path, params: { task: { title: 'Hello world', project_id: project.id } })
        expect(request).to redirect_to(project_path(project))
      end

      it 'can not add the task to an unassociated project', :js do
        post(tasks_path, params: { task: { title: 'Hello world', project_id: project.id } })
        expect(request).to redirect_to(new_user_session_path)
      end
    end
  end
end
