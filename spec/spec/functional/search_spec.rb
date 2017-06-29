feature 'Search', js: true do

  before { visit index_path }

  scenario 'User fills in the input with too short phrase' do
    find('#search-phrase').set('N')
    wait_for_ajax
    expect(page).to_not have_text /Found \d+ results?/i
  end

  scenario 'User fills in the input with suitable phrase' do
    find('#search-phrase').set('Nokia')
    wait_for_ajax
    expect(page).to have_text /Found \d+ results?/i
    expect(page).to have_text /Nokia/i
  end

  scenario 'User clicks a button to show search result details' do
    find('#search-phrase').set('Samsung')
    wait_for_ajax
    expect(page).to have_selector '.js-toggle-search-result-details', visible: true
    first('.js-toggle-search-result-details').tap do |toggle|
      toggle.click
      expect(toggle).to have_text toggle['data-loading-text']
      wait_for_ajax
      expect(toggle).to have_text toggle['data-on-text']
      expect(page).to have_selector '.js-search-result-details', visible: true
    end
  end
end
