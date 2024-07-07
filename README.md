# Kbot

A Telegram bot built using Go and the `telebot` library. This bot responds to text messages with predefined responses.

## Bot Link

You can interact with the bot at [t.me/<Your_Bot_Name>_bot](https://t.me/<Your_Bot_Name>_bot).

## Installation

To install and run the bot, follow these steps:

1. Clone the repository:
    ```sh
    git clone https://github.com/yourusername/kbot.git
    cd kbot
    ```

2. Install the required dependencies:
    ```sh
    go get ./...
    ```

3. Set the environment variable `TELE_TOKEN` with your Telegram bot token:
    ```sh
    export TELE_TOKEN="your-telegram-bot-token"
    ```

4. Build and run the bot:
    ```sh
    go build -o kbot
    ./kbot
    ```

## Usage

### Commands

- `hello`: The bot will respond with a greeting message including its version.

### Example

Send the following message to the bot:
