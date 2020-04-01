require 'rails_helper'

RSpec.describe ProjectsController, type: :controller do
  describe 'create' do
    it 'calls the workflow with parameters' do
      workflow = instance_spy(CreatesProject, success?: true)
      allow(CreatesProject).to receive(:new).and_return(workflow)
      post :create, params: { project: { name: 'Project X', tasks: 'make it:3' } }
      expect(CreatesProject).to have_received(:new).with(name: 'Project X', task_string: 'make it:3')
    end
  end
end
