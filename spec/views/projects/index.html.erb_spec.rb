require 'rails_helper'

describe 'projects/index' do
  let(:on_schedule) { FactoryBot.build_stubbed(
    :project, due_date: 1.year.from_now, tasks: [completed_task]) }
  let(:completed_task) { FactoryBot.build_stubbed(
    :task, completed_at: 1.day.ago, size: 1) }


  let(:behind_schedule) { FactoryBot.build_stubbed(
    :project, due_date: 1.day.from_now, name: 'Behind Schedule', tasks: [incomplete_task]) }
  let(:incomplete_task) { FactoryBot.build_stubbed(:task, size: 1) }

  it 'renders the index page with correct dom elements' do

    @projects = [on_schedule, behind_schedule]
    render
    expect(rendered).to have_selector("#project_#{on_schedule.id} .on_schedule")
    expect(rendered).to have_selector("#project_#{behind_schedule.id} .behind_schedule")
  end
end
