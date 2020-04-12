require 'rails_helper'

describe ProjectPresenter do
  let(:project) { instance_double(Project, name: 'Project Runaway') }
  let(:presenter) { ProjectPresenter.new(project) }

  it 'handles a name with on time status' do
    allow(project).to receive(:on_schedule?).and_return(true)
    expect(presenter.name_with_status).to eq(
      "<span class='on_schedule'>Project Runaway</span>"
    )
  end

  it 'handles a name with behind schedule status' do
    allow(project).to receive(:on_schedule?).and_return(false)
    expect(presenter.name_with_status).to eq(
      "<span class='behind_schedule'>Project Runaway</span>"
    )
  end
end
