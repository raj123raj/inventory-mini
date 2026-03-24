pipeline {
    agent any

    environment {
        PHP_PATH       = 'D:\\Priya\\softwares\\php\\php.exe'
        COMPOSER_PATH  = 'D:\\Priya\\softwares\\composer\\composer.bat'
		MYSQL_PATH     = 'C:\\Program Files\\MySQL\\MySQL Server 5.7\\bin\\mysql.exe' 
		MYSQL_PASSWORD = 'mysql'
    }

    stages {
	
	  stage('Checkout') {
            steps {
                git branch: 'main',
                    credentialsId: 'github-raj123raj',
                    url: 'https://github.com/raj123raj/inventory-mini'
            }
        }

        stage('Dependencies') {
            steps {
                // Verify composer.json exists in workspace
                bat 'dir composer.json'         
                
                // Install PHP dependencies -> creates vendor/autoload.php
                bat "%COMPOSER_PATH% install --no-progress --no-interaction"
				
            }
        }
	
	  stage('Environment') {
		steps {
			bat """
			copy /Y .env.example .env
			"%PHP_PATH%" artisan key:generate --force
			"""
		}
	  }
        
      stage('Test DB') {
            steps {
				bat """
				"%MYSQL_PATH%" -h localhost -u root -p%MYSQL_PASSWORD% -e "DROP DATABASE IF EXISTS laravel;"
				"%MYSQL_PATH%" -h localhost -u root -p%MYSQL_PASSWORD% -e "CREATE DATABASE laravel CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;"
				"%PHP_PATH%" artisan migrate:fresh --seed
				"""

            }
        }	
    }


}
