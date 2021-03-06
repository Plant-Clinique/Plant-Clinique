require "application_system_test_case"

class ChatbotMessagesTest < ApplicationSystemTestCase
  setup do
    @chatbot_message = chatbot_messages(:one)
  end

  test "visiting the index" do
    visit chatbot_messages_url
    assert_selector "h1", text: "Chatbot Messages"
  end

  test "creating a Chatbot message" do
    visit chatbot_messages_url
    click_on "New Chatbot Message"

    fill_in "Content", with: @chatbot_message.content
    check "From bot" if @chatbot_message.from_bot
    fill_in "Time sent", with: @chatbot_message.time_sent
    fill_in "User", with: @chatbot_message.user_id
    click_on "Create Chatbot message"

    assert_text "Chatbot message was successfully created"
    click_on "Back"
  end

  test "updating a Chatbot message" do
    visit chatbot_messages_url
    click_on "Edit", match: :first

    fill_in "Content", with: @chatbot_message.content
    check "From bot" if @chatbot_message.from_bot
    fill_in "Time sent", with: @chatbot_message.time_sent
    fill_in "User", with: @chatbot_message.user_id
    click_on "Update Chatbot message"

    assert_text "Chatbot message was successfully updated"
    click_on "Back"
  end

  test "destroying a Chatbot message" do
    visit chatbot_messages_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Chatbot message was successfully destroyed"
  end
end
