require 'rails_helper'

RSpec::Matchers.define :be_able_to_see do |projects|
  match do |user|
    expect(user.visible_projects).to eq(projects)
    projects.all? { |prj| expect(user.can_view?(prj)).to be_truthy }
    (all_projects - projects).all? do |prj|
      expect(user.can_view?(prj)).to be_falsey
    end
  end
end

RSpec.describe User, type: :model do
  let(:project) { create(:project) }
  let(:user) { create(:user) }

  context 'generic access' do
    it 'can not view project if it is not part of it' do
      expect(user.can_view?(project)).to be_falsy
    end

    it 'can view a project if it is a part of it' do
      Role.create(project: project, user: user)
      expect(user.can_view?(project)).to be_truthy
    end
  end

  context 'public roles' do
    it 'allows to admin view project' do
      user.admin = true
      expect(user.can_view?(project)).to be_truthy
    end

    it 'allows an user to view public project' do
      project.update_attributes(public: true)
      expect(user.can_view?(project)).to be_truthy
    end
  end

  context 'visible projects' do
    let(:project_1) { create(:project, name: 'Project 1') }
    let(:project_2) { create(:project, name: 'Project 2') }
    let(:all_projects) { [project_1, project_2] }

    it 'allows an user to see their projects' do
      user.projects << project_1
      expect(user).to be_able_to_see([project_1])
      expect(user).to_not be_able_to_see([project_2])
    end

    it 'allows an admin to see all projects' do
      user.admin = true
      expect(user).to be_able_to_see([project_1, project_2])
    end

    it 'allows an user to see public projects' do
      user.projects << project_1
      project_2.update(public: true)
      expect(user).to be_able_to_see([project_1, project_2])
    end

    it 'has no duplications in project list' do
      user.projects << project_1
      project_1.update(public: true)
      expect(user).to be_able_to_see([project_1])
    end
  end
end
