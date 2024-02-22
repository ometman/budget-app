# Budget App: Ometman

<a name="readme-top"></a>

<div align="center">
  <img src="./ometman-logo.png" alt="logo" width="140"  height="auto" />
  <br/>
  <h3><b>Budget App: by Ometman</b></h3>
  <h5>Budget App is a beautiful Ruby on Rails mobile web application for managing your budget. Users who must login, can create expense categories and transactions specific to each.  The home shows categories specific to the logged in user and shows total amount from all categories. Clicking a category shows how much money you spent and on what, with specific total in that category.  Data is private to the logged in user. The power of rails is employed to build models, controllers and views that allows easy CRUD funtionality to be performed. Built on a simple Entity Relational Diagram it has a simple UI for a rich UX. 
  What more? Enjoy it!
</div>

# 📗 Table of Contents

- [Budget App: Ometman](#budget-app-ometman)
- [📗 Table of Contents](#-table-of-contents)
- [📖 Ometman Budget App ](#-ometman-budget-app-)
  - [🛠 Built With ](#-built-with-)
    - [Tech Stack ](#tech-stack-)
    - [Key Features ](#key-features-)
  - [💻 Getting Started ](#-getting-started-)
    - [Prerequisites](#prerequisites)
    - [Setup](#setup)
    - [Install Packages and Run Tests ](#install-packages-and-run-tests-)
    - [Usage ](#usage-)
    - [Deployment](#deployment)
    - [Authors](#authors)
  - [🔭 Future Features ](#-future-features-)
  - [🤝 Contributing ](#-contributing-)
  - [⭐️ Show your support ](#️-show-your-support-)
  - [🙏 Acknowledgments ](#-acknowledgments-)
  - [❓ FAQ ](#-faq-)
  - [📝 License ](#-license-)

# 📖 Ometman Budget App <a name="about-project"></a>

**A Demo Video: Introduction to this Project**
--[Budget Demo](https://www.loom.com/share/7c5642f53ab6429cbbdd520937e72812?sid=3b5006c2-5d4e-4eb2-bcf0-ad366796f2f3)

> The project is mobile-oriented designs for different screen sizes.

- It is accessible on any screen.
- Better view on Mobile Devices and Ipads.

> Project Brief :
- It is a Ruby on Rails Project
- It is built on a real-life data structure by Microverse.
- It uses a Relational Database system
- It uses Postgresql.
- It is ACID ( Atomicity, Consitency, Isolation, Durablity) compliant.
- It perform CRUD functionality in user-specific basic personal finance management.
- It is based on TDD (Test-Driven Development)

## 🛠 Built With <a name="built-with"></a>

### Tech Stack <a name="tech-stack"></a>

<details>
  <summary>Client</summary>
  <ul>
    <li>Ruby on Rails</>
    <li>Postgresql</li>
    <li>Database Management Server funtionalities</li>
    <li>Real-life structure</li>
    <li>Styelint and Rubocop for best practices</li>
    <li>Rspec,  for testing</li>
  </ul>
</details>

<details>
  <summary>Server</summary>
  <ul>
    <li>PostgreSql Server</li>
    <li>Github Servers</li>
    <li>Rails Server</li>
    <li>Render Servers</li>
  </ul>
</details>

<details>
  <ul>
    <li>PostgreSql Database</li>
  </ul>
</details>

### Key Features <a name="key-features"></a>

- **Conversion of a real wireframe using Rails***
- **Creating a User**
- **Creating, querying, updating and auditing transacations by database**
- **Schema development and application in migration**
- **Create User Account, Categories and Transactions**
- **Employs Devise and Cancancan for authentication and authorization respectively**


<p align="right">(<a href="#readme-top">back to top</a>)</p>

<p align="right">(<a href="#readme-top">back to top</a>)</p>

## 💻 Getting Started <a name="getting-started"></a>

To get a local copy up and running, follow these steps.

### Prerequisites

In order to run this project you need:

- Git (for running git related commands only)
- An IDE (e.g. VS Code) - For viewing and accessing the files only
- A system with a good OS like Mac Os, Linux or Windows etc
- PostgreSql (https://www.postgresql.org/download/)
- Ruby on Rails (https://gorails.com/setup/windows/10)

### Setup

- Depending on your OS, download and install PostgreSql:
  - You may watch this video (https://www.youtube.com/watch?v=KuQUNHCeKCk)
- Open your code editor (e.g. VS Code).
- At the terminal, clone this repository to your desired directory.
- Make sure the PostgreSql server is running
  - You may refer to https://www.postgresql.org/docs/current/tutorial-start.html
- Download and install Ruby on Rails
  - Following the instructions at https://gorails.com/setup/windows/10

- Use `git clone` to get your local copy of the project.
  >> At the prompt (bash) enter:
  ```
  git clone https://github.com/ometman/budget-app.git
  ```

### Install Packages and Run Tests <a name="install"></a>

 Run `npm install` and `bundle install` to set up the required packages and gems.

```
bash > npm install
````
```
bash > bundle install
````
 Run Tests <a name="run-tests"></a>
  To run tests run the following command in your terminal
    ```
    Rspec
    ```

 Run Linters
  - You can also check linter errors
  - Make sure Rubocop and stylelint are installed
     Install Rubocop, run the following command:
    ```
    gem install --no-document rubocop -v '>= 1.0, < 2.0'
    ```
    Install Stylelint, run the following command:
    ```
    npm install --save-dev stylelint@13.x stylelint-scss@3.x stylelint-config-standard@21.x stylelint-csstree-validator@1.x
    ```
  - Now, run the following:
    ```
    npx stylelint "**/*.{css,scss}"
    ```

### Usage <a name="usage"></a>

To run the project locally, execute the following command:

- Start and login to the database server (for Windows): 
  ```
  run psql
  ```
  Or start PgAdmin

- Launch the app with the following command to start the rails server:
  ``
  rails s
 ``
 
- Voila! Now, go to the browser and enter: localhost:3000 or 127.0.0.1:3000

### Deployment

You can deploy this project using:

- GitHub Pages from a specific branch (e.g. main).
- You can also used any cloud service like gcloud or Azure.
- A deployed version can be found here:
 [https://proper-rivalee-microverse-student.koyeb.app/]
- Currently, use the following login details: 
  Email: ometman.dev.mail@gmail.com
  pwd:  asdfgh

<p align="right">(<a href="#readme-top">back to top</a>)</p>

### Authors

👤 **Omet Omeni (Ometman)**

- GitHub: [@ometman](https://github.com/ometman)
- LinkedIn: [LinkedIn](https://www.linkedin.com/in/ometman/)

<p align="right">(<a href="#readme-top">back to top</a>)</p>

## 🔭 Future Features <a name="future-features"></a>

- **Advance categorization and tagging**
- **Improving UI design**
- **Adding a help information**
- **Adding contact information**
- **Full desktop version**
- **Menu Implementation**

<p align="right">(<a href="#readme-top">back to top</a>)</p>

## 🤝 Contributing <a name="contributing"></a>

Contributions, issues, and feature requests are welcome!

Feel free to check the [issues page](https://github.com/ometman/blogtalk/issues).

<p align="right">(<a href="#readme-top">back to top</a>)</p>

## ⭐️ Show your support <a name="support"></a>

As a tech enthusiast, your support is always appreciated. If you like this project please do let us know with your support in any way you see fit.

<p align="right">(<a href="#readme-top">back to top</a>)</p>

## 🙏 Acknowledgments <a name="acknowledgements"></a>

I would like to thank especially [Microverse](https://www.microverse.org/) for inspiring this project & project guidelines.
Thanks to Gregoire Vella for the design (https://www.behance.net/gregoirevella)

<p align="right">(<a href="#readme-top">back to top</a>)</p>

## ❓ FAQ <a name="faq"></a>

- **Can I fork this project?**

  - Yes, feel free to fork and knock yourself out :) .

- **Can I share this project with others?**
  - Yes, you can share this project for any educational purposes.

<p align="right">(<a href="#readme-top">back to top</a>)</p>

## 📝 License <a name="license"></a>

This project is [MIT](./LICENSE) licensed.

<p align="right">(<a href="#readme-top">back to top</a>)</p>
