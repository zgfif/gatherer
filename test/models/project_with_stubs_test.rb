require 'test_helper'

class ProjectWithStubsTest < ActiveSupport::TestCase
  test 'lets stub an object' do
    project = Project.new
    project.stubs(:name)
    assert_nil(project.name)
  end

  test 'lets stub an object again' do
    project = Project.new
    project.stubs(name: 'Sam')
    assert_equal('Sam', project.name)
  end

  test 'lets stub a class' do
    Project.stubs(:find).with(1).returns(Project.new(name: 'Project Greenlight'))
    project = Project.find(1)
    assert_equal('Project Greenlight', project.name)
  end

  test 'a sample mock' do
    mocky = mock(name: 'Radik', weight: 105)
    assert_equal(105, mocky.weight)
    assert_equal('Radik', mocky.name)
  end

  test 'lets mock an object' do
    mock_project = Project.new(name: 'Project Greenlight')
    mock_project.expects(:name).returns('Fred')
    assert_equal('Fred', mock_project.name)
  end

  test 'stub with multiple returns' do
    stubby = Project.new
    stubby.stubs(:user_count).returns(1).then.returns(2)
    assert_equal(1, stubby.user_count)
    assert_equal(2, stubby.user_count)
    assert_equal(2, stubby.user_count)
  end

  test 'lets stub with block' do
    proj = Project.new
    proj.stubs(:status).with {|st| st % 2 == 0 }.returns('Active')
    proj.stubs(:status).with { |st| st % 3 == 0 }.returns('Asleep')
    assert_equal('Active', proj.status(2))
    assert_equal('Asleep', proj.status(12))
  end

  test 'lets stub with depending from type' do
    project = Project.new
    project.stubs(:tasks_before).with(instance_of(Date)).returns(3)
    project.stubs(:tasks_before).with(Not(instance_of(Date))).raises(NoMethodError)
    # project.stubs(:tasks_before).with(instance_of(String)).raises(NoMethodError)
    assert_equal(3, project.tasks_before(Date.today))
    assert_raises NoMethodError do
      project.tasks_before('text')
    end
  end

  test 'proj has entry' do
    proj = Project.new
    proj.expects(:options).with(has_entry(verbose: true))
    assert_nil(proj.options({verbose: true}))
  end
end
