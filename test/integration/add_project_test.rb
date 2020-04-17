require 'test_helper'

class AddProjectTest < ActionDispatch::IntegrationTest
  test 'allows a user to create a project with tasks' do
    post(projects_path, params: { project: { name: 'Project Runaway', tasks: "Choose Fabric:3\nMake It Work:5" } })
    @project = Project.find_by(name: 'Project Runaway')
    follow_redirect!
    # assert_select("#project_#{@project.id} .name", text: 'Project Runaway')
    assert_select("#project_#{@project.id}") do |matches|
      matches.each do |element|
        assert_select(element, ".name", text: 'Project Runaway')
      end
    end
    assert_select("#project_#{@project.id} .total-size", text: '8')
  end

  test 'does not allow a uses to create a project without name' do
    post(projects_path, params: { project: { name: '', tasks: "Choose Fabric:3\nMake It Work:5" } })
    assert_select('.new_project')
  end

  test 'it behaves correctly with a database failure' do
    workflow = stub(success?: false, create: false, project: Project.new)

    CreatesProject.stubs(:new).with(
      name: 'Project Runaway',
      task_string: "Choose Fabric:3\nMake It Work:5").returns(workflow)
    post(projects_path, params: { project: { name: 'Project Runaway', tasks: "Choose Fabric:3\nMake It Work:5" } })

    assert_select('.new_project')
  end
end
