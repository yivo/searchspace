# encoding: UTF-8
# frozen_string_literal: true

describe '"Hello, world!" caption', type: :feature do
  scenario 'User opens index page' do
    visit index_path
    expect(page).to have_text('Hello, world!')
  end
end
