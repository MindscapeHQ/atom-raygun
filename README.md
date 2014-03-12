# atom-raygun package

Atom plugin for viewing errors on Raygun and navigating to the errors within your project.

## Current features
- view a list of your Raygun applications
- view top 20 most recent errors for individual applications
- navigate to the file that individual errors occurred in

## Current issues
- need to set an API key in the settings page, this will be exposed on the website shortly
- locating files will open the best guess at the file in question. This is located by looking at the first line of the stack trace and looking at the file name provided there. It then finds the best match for the file and opens it
