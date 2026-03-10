pipeline {
    agent any

    environment {
        PHP_PATH       = 'D:\\Priya\\softwares\\php\\php.exe'
        COMPOSER_PATH  = 'D:\\Priya\\softwares\\composer\\composer.bat'
		NODE_PATH      = 'D:\\Priya\\softwares\\nodejs\\node.exe'
		MYSQL_PATH     = 'C:\\Program Files\\MySQL\\MySQL Server 5.7\\bin\\mysql.exe' 
		MYSQL_PASSWORD = 'mysql'
    }

    stages {
        
      stage('Test DB') {
            steps {
                bat """
                if exist database\\database.sqlite del database\\database.sqlite
                "%PHP_PATH%" artisan migrate:fresh --seed
                """
				bat """
				"%MYSQL_PATH%" -h localhost -u root -p%MYSQL_PASSWORD% -e "DROP DATABASE IF EXISTS my_test_db;"
				"%MYSQL_PATH%" -h localhost -u root -p%MYSQL_PASSWORD% -e "CREATE DATABASE my_test_db CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;"
				"%PHP_PATH%" artisan migrate:fresh --seed
				"""

            }
        }	
    }


}
