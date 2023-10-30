# Petto
Petto is an app that helps owners keep their pets healthy and happy.

## Clone

1. Open your terminal or command line interface.

2. Navigate to the directory where you want to clone the repository.

3. Use the git clone command followed by the repository's URL. The command should look like this:   
```git clone https://github.com/username/repository.git```

4. When cloning the repository, you need to execute the command  ```flutter gen-l10n```  to automatically generate the classes that will help us manage the localizations.


## Localizations

This project utilizes localization with the assistance of the **intl** and **flutter_localizations** packages. Follow the steps below to set it up:

1. After the dependencies are installed, you need to add the required texts to the translations. Open the .arb files located in the lib/l10n/ directory. Each file represents a different language. For each text, specify a key-value pair using the following format: "key": "value"

2. Once you have added the texts, execute the following command to load the new translations: ```flutter gen-l10n```  This will ensure that the added texts are properly integrated into the application.

3. This will ensure that the added texts are properly integrated into the application: **AppLocalizations.of(context).key**, So all the texts in widgets are referenced this way, and under no circumstances should you use hardcoded texts.
