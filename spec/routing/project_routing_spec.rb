require 'rails_helper'

RSpec.describe 'project routing', :aggregate_failures, type: :routing do
  it 'routes projects' do
    expect(get: '/projects').to route_to(controller: 'projects', action: 'index')
    expect(post: '/projects').to route_to(controller: 'projects', action: 'create')
    expect(get: '/projects/new').to route_to(controller: 'projects', action: 'new')
    expect(get: '/projects/1').to route_to(controller: 'projects', action: 'show', id: '1')
    expect(get: '/projects/1/edit').to route_to(controller: 'projects', action: 'edit', id: '1')
    expect(patch: '/projects/1').to route_to(controller: 'projects', action: 'update', id: '1')
    expect(delete: '/projects/1').to route_to(controller: 'projects', action: 'destroy', id: '1')
    expect(get: 'projects/search/fred').to_not be_routable
  end

  it 'routes tasks' do
    expect(patch: '/tasks/1/up').to route_to(controller: 'tasks', action: 'up', id: '1')
    expect(patch: '/tasks/1/down').to route_to(controller: 'tasks', action: 'down', id: '1')
  end
end
