
# Video Streaming

A company needs a RoR solution for video upload, conversion and streaming capability. The
company has many clients who will use the solution.
All functionality can run locally with your selection of gems used where appropriate (for instance
video transcoding).

## Getting Started

To get started with this project, you need to clone or download it locally, then follow the steps below to install dependencies and start the project.

### Prerequisites
Also make sure you have Ruby, PostgreSQL and redis installed. You can check
if they are installed by running:
```bash
ruby -v

psql -V

redis-server -v
```
Also Make sure you have Node.js and npm installed. You can check if they are installed by running:

```bash
node -v

npm -v
```

If these commands return version numbers, then you have everthing installed.



### Installation

Clone the repository to your local machine, then run the following command in the project's root directory to install dependencies:

```bash
bundle install

rails db:setup
rails db:migrate
```

### Starting the Project
After installing the dependencies, you can start the project by running:

```bash
bin/dev
```

This command will start the project, usually opening a local server where you can view the application in your web browser at localhost:3000/users/sign_up. 