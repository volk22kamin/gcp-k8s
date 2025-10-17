# Project Codex: Infrastructure Architecture

This document outlines the file architecture for this project. It is intended to be used as a reference for maintaining a consistent and organized structure.

## Root Directory

The root directory contains the core project files and directories.

```
/
├── .gitignore
├── README.md
├── docs/
├── environments/
├── modules/
└── scripts/
```

-   **`.gitignore`**: Specifies files and directories to be ignored by Git.
-   **`GEMINI.md`**: Provides context for the Gemini AI assistant.
-   **`README.md`**: The main README file for the project.
-   **`docs/`**: Contains project documentation.
-   **`environments/`**: Holds the configuration for different deployment environments (e.g., `dev`, `staging`, `prod`).
-   **`modules/`**: Contains reusable Terraform modules that define specific parts of the infrastructure.
-   **`scripts/`**: Includes helper scripts for development and automation.

## Environments

The `environments` directory separates configurations for each deployment environment.

```
environments/
└── <environment-name>/
    ├── README.md
    ├── shared.tf
    └── <component-name>/
        ├── .terraform.lock.hcl
        ├── backend.tf
        ├── main.tf
        ├── outputs.tf
        ├── provider.tf
        └── variables.tf
```

-   **`<environment-name>/`**: A directory for each environment (e.g., `dev`).
    -   **`README.md`**: A README specific to the environment.
    -   **`shared.tf`**: Contains shared Terraform variables and locals for the environment. and is added to every <component-name> as a symlink for it to have the sahred data.
    -   **`<component-name>/`**: A directory for each infrastructure component (e.g., `database`, `networking`).
        -   **`backend.tf`**: Configures the Terraform backend for state storage.
        -   **`main.tf`**: The main entrypoint for the component's Terraform code, which typically instantiates a module from the `modules/` directory.
        -   **`outputs.tf`**: Defines the outputs for the component.
        -   **`provider.tf`**: Specifies the Terraform providers and their versions.
        -   **`variables.tf`**: Declares the input variables for the component.

## Modules

The `modules` directory contains reusable Terraform modules.

```
modules/
└── <module-name>/
    ├── README.md
    ├── data.tf
    ├── main.tf
    ├── outputs.tf
    ├── variables.tf
    └── versions.tf
```

-   **`<module-name>/`**: A directory for each reusable module.
    -   **`README.md`**: Documentation for the module.
    -   **`data.tf`**: Defines Terraform data sources.
    -   **`main.tf`**: The main logic of the module.
    -   **`outputs.tf`**: Declares the outputs of the module.
    -   **`variables.tf`**: Defines the input variables for the module.
    -   **`versions.tf`**: Specifies provider version constraints for the module.

## Scripts

The `scripts` directory contains utility scripts.

```
scripts/
└── create-module.sh
```

-   **`create-module.sh`**: A script to scaffold a new module, ensuring consistency across the project.
