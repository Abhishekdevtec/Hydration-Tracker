# Hydration Tracker

A Ruby on Rails application to track daily beverage consumption and hydration habits.

## Features

- Track different types of beverages (water, coffee, tea, etc.)
- Record consumption quantity, temperature, and time
- Mobile-friendly responsive design
- Simple intuitive interface

## Technologies

- Ruby 3.4.2
- Rails 8.0.2
- sqlite3
- Tailwind CSS for styling
- Hotwire/Stimulus for interactive elements

## Prerequisites

- Ruby 3.4.2
- Rails 8.0.2
- Bundler
- sqlite3
- Node.js (for JavaScript package management)

## Installation

1. Clone the repository:
   ```bash
   git clone https://github.com/your-username/hydration_tracker.git
   cd hydration_tracker

2. Install dependencies:

   ```bash
      bundle install
      yarn install

3. Set up database:

   ```bash
    rails db:create
    rails db:migrate

4. Seed with sample data:

    ```bash
    rails db:seed

5. Start the server:

   ```bash
    rails server
    Visit http://localhost:3000 in your browser.
