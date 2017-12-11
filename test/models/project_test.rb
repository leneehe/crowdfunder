require 'test_helper'

class ProjectTest < ActiveSupport::TestCase

  test 'valid project can be created' do
    owner = new_user
    owner.save
    project = new_project
    project.user = owner
    project.save
    assert project.valid?
    assert project.persisted?
    assert project.user
  end

  test 'project is invalid without owner' do
    project = new_project
    project.user = nil
    project.save
    assert project.invalid?, 'Project should not save without owner.'
  end

  def new_project
    Project.new(
      title:       'Cool new boardgame',
      description: 'Trade sheep',
      start_date:  Date.today,
      end_date:    Date.today + 1.month,
      goal:        50000
    )
  end

  def new_user
    User.new(
      first_name:            'Sally',
      last_name:             'Lowenthal',
      email:                 'sally@example.com',
      password:              'passpass',
      password_confirmation: 'passpass'
    )
  end

  test 'time left displays days left' do
    owner = new_user
    owner.save
    project = Project.new(
      title:       'Cool new boardgame',
      description: 'Trade sheep',
      start_date: DateTime.now.utc,
      end_date: DateTime.now.utc + 1.month,
      goal:        50000,
      user:        owner,
    )
    project.save

    expected = "30 days, 23 hours"
    actual = project.time_left

    assert_equal expected, actual
  end

end
