## **Thought Process**:

The thought process is based processes of Input, Process, Output. It is expected the user throws in a command, the code processes it and the user gets the output. However, the underlying though processed is about Extensibility and Dependency Inversion so as to not create a loosely coupled code. In short, the SOLID Principles.

Therefore, there are three Ruby files;

1. the LogProcessor.rb, which processes the file/log and returns a processed file in an OpenStruct as a one-off object. Its processes started by creating a class with a Struct, for creating a value object to store related attributes in the file together.


2. the LogPrinter.rb, which is independent of log processor. It takes the object of the OpenStruct as webpage statistics and writes it in an expected or usable data structure. LogPrinter uses some helper classes (LogPrinter::List and LogPrinter::Table) with dependency inversion of the SOLID Principles. 


3. the Parser.rb which handles all the user interactions and taking the lead on calling the necessary code to render results to users. 

## **Set/Configuration**:

The code is written in Ruby v3.0.0 and it’s expected you have Ruby installed on your computer system. If not, install Ruby on your system and test if it’s perfectly installed by running the command below to check if a version is available on your system. 

> ruby -version

## **Usage**:

How to use this code is by running the command below:

> ruby ./parser.rb webserver.log

Running Test
This code uses Minitest. You can run the test by running the command below:

> ruby test/test.rb
