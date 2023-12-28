Estos scripts solo funcionan en plesk.

0. Instalar el awscli: apt install awscli
1. correr el comando aws configure y poner las credenciales de un nuevo usuarios en IAM que tenga acceso a S3
3. Guardar los scripts en home/ubuntu
5. cambiar los permisos a los scripts ej. chmod +x databases-to-s3.sh
6. crear la carpeta mkdir /var/www/vhosts/sqlbackups/
7. Modificar los scripts para que contengan el bucket y demas configuraciones correctas
8. correr el script y validar su funcionamiento
9. Crear tarea que ejecute los scripts en plesk. 
