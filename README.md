# appecg

Aplicación móvil diseñada para brindar a los profesionales médicos una herramienta integral y eficiente para la gestión de electrocardiogramas (ECG). Esta permite capturar, almacenar y analizar de manera segura la información crucial asociada con los ECG de los pacientes, realizando una predicción sobre la posibilidad de riesgo de experimentar una arritmia, mediante la implementacion de un modelo de red neuronal.

# Requisitos

Flutter 3.16.0
Dart 3.2.0
Visual Studio Community 2022 17.7.5
Android Studio 2022.3
Java 17.0.9
VS Code 1.84.2

## Configuracion

1. Se puede utilizar esta guía de instalación de Flutter para llevar a cabo el proceso de instalación y configuración de los requisitos en el sistema operativo Windows. El enlace a la guía completa se encuentra aquí:
https://docs.flutter.dev/get-started/install/windows

2. Verifica la version de Java:
java -version

3. Asegúrate de tener Flutter y los demás requisitos instalados. Puedes comprobarlo ejecutando el siguiente comando:
flutter doctor

4. Instala las dependencias del proyecto ejecuntado el siguiente comando en la carpeta raiz del proyecto:
flutter pub get

5. Para ejecutar el proyecto:
flutter build


## Cascade Haar

# Requisitos
Python 3.11.5
pip

# Configuracion

1. Verifica la version de Python
python -–version

2. Crear un entorno virtual en la raíz del proyecto:
python -m venv venv

3. Activar el entorno virtual
venv\Scripts\activate

4. instalar las siguientes librerias:
pip install opencv-python
pip install numpy
pip install imutils

5. instalar la herramienta Cascade Trainer GUI desde el siguiente link:
https://amin-ahmadi.com/cascade-trainer-gui/

6. Para proceso de entrenamiento, será necesario organizar las imágenes positivas y negativas en dos carpetas distintas, denominadas 'p' y 'n', respectivamente. Las imagenes positivas deben tener presente el objeto que se desea detectar, y las negativas no lo deben tener presente. Es importante que estas imágenes no sean excesivamente grandes, ya que esto podría ralentizar el proceso de detección.

# Entrenamiento

Una vez esten listas las imágenes para el entrenamiento, nos dirigimos al programa Cascade Trainer GUI.

1. En la pestaña Input
    1.1. Samples Folder: La direccion de la carpeta que contiene los directorios de imagenes positivas y negativas.
    1.2. Positive Image Usage: Especificar el porcentaje de imagenes positivas que se usaran en el entrenamiento.
    1.3. Negative Image Acount: Especificar la cantidad de imágenes negativas a usar para el entrenamiento.

2. En la pestaña Common no es necesario realizar ninguna modificación.

3. En la pestaña Cascade se ingresan el ancho y alto que poseen las imágenes de entrenamiento.

4. Ejecutar y esperar que se complete el entrenamiento.

5. Al finalizar el entrenamiento, dirigirse a la carpeta que contiene 'p' y 'n'. Alli se encontra una nueva carpeta llamada 'clasiffier'.

6. En esta carpeta se encontrara el archivo cascade.xml que corresponde al modelo que permitira realizar pruebas de detección del objeto.

