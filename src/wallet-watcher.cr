require "libnotify"
require "garlicoin"
require "http/client"
require "./wallet-watcher/*"

class WalletWatcher

  SLEEP_TIME = 10
  ICON_PATH = File.join(ENV["HOME"], ".garlicoin/garlicoin.svg")

  @config : Garlicoin::Config
  @client : Garlicoin::Client

  def initialize
    @config = Garlicoin::Config.load
    @client = Garlicoin::Client.new(@config)

    check_for_icon
  end

  def poll
    starting_balance = @client.get_balance

    loop do
      current_balance = @client.get_balance
      formatted_current_balance = format_balance(current_balance)
      puts "Polling balance. Current balance ₲#{formatted_current_balance}"

      if current_balance > starting_balance
        difference = format_balance(current_balance - starting_balance)
        message = "You received ₲#{difference}! Your new wallet balance is ₲#{formatted_current_balance}."
        notification = Libnotify.new(summary: "You received garlic!", body: message, timeout: 5, icon_path: ICON_PATH).show
        puts "₲#{difference} received"
      elsif current_balance < starting_balance
        difference = format_balance(starting_balance - current_balance)
        message = "You sent ₲#{difference}! Your new wallet balance is ₲#{formatted_current_balance}."
        notification = Libnotify.new(summary: "You sent garlic!", body: message, timeout: 5, icon_path: ICON_PATH).show
        puts "₲#{difference} sent"
      end

      starting_balance = current_balance
      sleep(SLEEP_TIME)
    end
  end

  private def check_for_icon
    if !File.exists?(ICON_PATH)
      puts "Garlicoin icon doesn't exist. Downloding to #{ICON_PATH}."
      download_icon
    end
  end

  private def download_icon
    HTTP::Client.get("http://svgur.com/i/59w.svg") do |response|
      File.write(ICON_PATH, response.body_io)
      puts "Finished downloading icon."
    end
  end

  private def format_balance(balance)
    "%.10g" % balance
  end
end

watcher = WalletWatcher.new
watcher.poll
