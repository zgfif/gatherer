require 'test_helper'

class ProjectsHelperTest < ActionView::TestCase
  test 'project with status info' do
    project = Project.new(name: 'Project Runaway')
    project.stubs(:on_schedule?).returns(true)
    expected = "<span class='on_schedule'>Project Runaway</span>"
    actual = name_with_status(project)
    assert_dom_equal(expected, actual)
  end

  test 'project with status behind schedule' do
    project = Project.new(name: 'Project Runaway')
    project.stubs(:on_schedule?).returns(false)
    expected = "<span class='behind_schedule'>Project Runaway</span>"
    actual = name_with_status(project)
    assert_dom_equal(expected, actual)
  end

  test 'project using assert_select' do
    project = Project.new(name: 'Project Runaway')
    project.stubs(:on_schedule?).returns(false)
    assert_select_string(name_with_status(project), 'span.behind_schedule')
  end
end
