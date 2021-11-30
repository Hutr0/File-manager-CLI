import subprocess
import os
import json
import xml.etree.ElementTree as xml
import zipfile

path = '/Users/hutr0/Desktop/'

os.chdir(path)

class Menu():
    def show():
        print("""
        
                Menu
        1. Print info about file system
        2. Go to file menu
        3. Go to JSON menu
        4. Go to XML menu
        5. Go to ZIP menu
        6. Exit

        """)

        try:
            choice = int(input())
        except ValueError:
            print('\nError: Invalid number\n')
            Menu.show()
            return
        except Exception as e:
            print('\nSomething went wrong... Error: %s' %(e))
            Menu.show()
            return
        

        if choice == 1:
            VolumesInfo.getVolumeInfo()
        elif choice == 2:
            File().createFile()
        elif choice == 3:
            JSONClass().createJSON()
        elif choice == 4:
            XmlClass().createXml()
        elif choice == 5:
            ZipClass().showMenu()
        elif choice == 6:
            return
            
class VolumesInfo(): 
    def getVolumeInfo(): 
        p = subprocess.run(['diskutil', 'list'])
        print(p, '\n')

        Menu.show()

class File():

    filePath = ""

    def createFile(self):
        print('Enter a name of file')
        fileName = input()
        filePath = '%s%s.txt' %(path, fileName)

        try:
            file = open(filePath, 'w')
            file.close()
        except Exception as e:
            print('\nSomething went wrong... Error: %s' %(e))
            self.createFile()
            return
        
        self.filePath = filePath
        self.showMenu()

    def showMenu(self):
        print("""
        
            File
        1. Write to the file
        2. Read from the file
        3. Delete the file
        4. Go to main menu

        """)

        try:
            choice = int(input())
        except ValueError:
            print('\nError: Invalid number\n')
            self.showMenu()
            return
        except Exception as e:
            print('\nSomething went wrong... Error: %s' %(e))
            self.showMenu()
            return

        if choice == 1:
            self.writeToFile()
        elif choice == 2:
            self.readFromFile()
        elif choice == 3:
            self.deleteFile()
        elif choice == 4:
            Menu.show()
        else:
            print("Error: Number out of range")
            self.showMenu()

    def writeToFile(self):
        print('What do u want to write to the file?')
        string = input()

        try:
            file = open(self.filePath, 'w')
            file.write(string)
            file.close()
        except Exception as e:
            print('\nSomething went wrong... Error: %s' %(e))

        self.showMenu()

    def readFromFile(self):
        try:
            file = open(self.filePath, 'r')
            print(file.read())
        except Exception as e:
            print('\nSomething went wrong... Error: %s' %(e))

        self.showMenu()

    def deleteFile(self):
        # print(os.listdir())
        try:
            os.remove(self.filePath)
        except Exception as e:
            print('\nSomething went wrong... Error: %s' %(e))
        
        self.showMenu()
        
class JSONModel():
    def __init__(self, name, surname):
        self.name = name
        self.surname = surname
        
    name = ""
    surname = ""

class JSONClass():

    jsonPath = ''

    def createJSON(self):
        print('Enter a name of JSON')
        jsonName = input()
        jsonPath = '%s%s.json' %(path, jsonName)

        try:
            jsonFile = open(jsonPath, 'w')
            jsonFile.close()
        except Exception as e:
            print('\nSomething went wrong... Error: %s' %(e))
            self.createJSON()
            return

        self.jsonPath = jsonPath
        self.showMenu()

    def showMenu(self):
        print("""
        
                JSON
        1. Write to the JSON file some Data
        2. Read from the JSON file
        3. Delete the JSON file
        4. Go to main menu

        """)

        try:
            choice = int(input())
        except ValueError:
            print('\nError: Invalid number\n')
            self.showMenu()
            return
        except Exception as e:
            print('\nSomething went wrong... Error: %s' %(e))
            self.showMenu()
            return

        if choice == 1:
            self.writeToJSON()
        elif choice == 2:
            self.readFromJSON()
        elif choice == 3:
            self.deleteJSON()
        elif choice == 4:
            Menu.show()
        else:
            print("Error: Number out of range")
            self.showMenu()
    
    def writeToJSON(self):
#        data = {
#            "president": {
#                "name": "Zaphod Beeblebrox",
#                "species": "Betelgeusian"
#            }
#        }

        name = input("Enter a name: ")
        surname = input("Enter a surname: ")
        
        data = JSONModel(name, surname)

        try:
            JSONFile = open(self.jsonPath, 'w')
            json.dump(data.__dict__, JSONFile)
            JSONFile.close()
        except Exception as e:
            print('\nSomething went wrong... Error: %s' %(e))

        self.showMenu()

    def readFromJSON(self):
        try:
            JSONFile = open(self.jsonPath, 'r')
            print(json.load(JSONFile))
            JSONFile.close()
        except Exception as e:
            print('\nSomething went wrong... Error: %s' %(e))

        self.showMenu()

    def deleteJSON(self):
        try:
            os.remove(self.jsonPath)
        except Exception as e:
            print('\nSomething went wrong... Error: %s' %(e))
        
        self.showMenu()
    
class XmlClass():

    xmlPath = ''
    root = xml.Element("root")

    def createXml(self):
        print('Enter a name of Xml')
        xmlName = input()
        xmlPath = '%s%s.xml' %(path, xmlName)

        try:
            xmlFile = open(xmlPath, 'w')
            xmlFile.close()
        except Exception as e:
            print('\nSomething went wrong... Error: %s' %(e))
            self.createXml()
            return

        self.xmlPath = xmlPath
        self.showMenu()

    def showMenu(self):
        print("""
        
                XML
        1. Write to the XML file
        2. Read from the XML file
        3. Delete the XML file
        4. Go to main menu

        """)

        try:
            choice = int(input())
        except ValueError:
            print('\nError: Invalid number\n')
            self.showMenu()
            return
        except Exception as e:
            print('\nSomething went wrong... Error: %s' %(e))
            self.showMenu()
            return

        if choice == 1:
            self.writeToXml()
        elif choice == 2:
            self.readFromXml()
        elif choice == 3:
            self.deleteXml()
        elif choice == 4:
            Menu.show()
        else:
            print("Error: Number out of range")
            self.showMenu()

    def writeToXml(self):
        self.fillOutXML(self.root)

        try:
            xmlFile = open(self.xmlPath, 'wb')
            tree = xml.ElementTree(self.root)
            tree.write(xmlFile)
            xmlFile.close()
        except Exception as e:
            print('\nSomething went wrong... Error: %s' %(e))

        self.showMenu()

    def fillOutXML(self, root: xml.Element):
        current = root

        print("""
                
        Now you got a '%s' element
        1. Get all childs
        2. Select a child
        3. Add a child
        4. Set a value
        5. Return to root
        6. Save
        
        """ %(current.tag))

        try:
            choice = int(input())
        except ValueError:
            print('\nError: Invalid number\n')
            self.fillOutXML()
            return
        except Exception as e:
            print('\nSomething went wrong... Error: %s' %(e))
            self.fillOutXML()
            return

        if choice == 1:
            for child in current:
                print(child.tag, child.attrib)

            self.fillOutXML(current)
        elif choice == 2:
            i = 0
            for child in current:
                print("%s: %s" %(i, child.tag))
                i += 1
            
            print("Enter a number of child")
            try:
                number = int(input())
            except ValueError:
                print('\nError: Invalid number\n')
                self.fillOutXML(current)
                return
            except Exception as e:
                print('\nSomething went wrong... Error: %s' %(e))
                self.fillOutXML(current)
                return

            i = 0
            for child in current:
                if i == number:
                    current = child 
                i += 1

            self.fillOutXML(current)
        elif choice == 3:
            print("Enter a child name")
            childName = input()
            
            if childName == '':
                print("Error: Invalid child name\n")
                self.fillOutXML(current)
                return 

            xml.SubElement(current, childName)

            self.fillOutXML(current)
        elif choice == 4:
            print("Enter a string value")
            value = input()

            current.text = value

            self.fillOutXML(current)
        elif choice == 5:
            current = self.root

            self.fillOutXML(current)
        elif choice == 6:
            return
        else:
            print("Error: Number out of range")
            self.fillOutXML(current)

    def readFromXml(self):
        try:
            xmlFile = open(self.xmlPath, 'r')
            print(xmlFile.read())
            xmlFile.close()
        except Exception as e:
            print('\nSomething went wrong... Error: %s' %(e))

        self.showMenu()
    
    def deleteXml(self):
        try:
            os.remove(self.xmlPath)
        except Exception as e:
            print('\nSomething went wrong... Error: %s' %(e))
        
        self.showMenu()

class ZipClass():

    zipPath = ''

    def showMenu(self):
        print("""
        
                 ZIP
        1. Show all files on the desktop
        2. Make a ZIP
        3. UnMake a ZIP
        4. Delete an archive
        5. Go to main menu

        """)

        try:
            choice = int(input())
        except ValueError:
            print('\nError: Invalid number\n')
            self.showMenu()
            return
        except Exception as e:
            print('\nSomething went wrong... Error: %s' %(e))
            self.showMenu()
            return

        if choice == 1:
            self.showFiles()
            self.showMenu()
        elif choice == 2:
            self.makeZip()
        elif choice == 3:
            self.unmakeZip()
        elif choice == 4:
            self.deleteZip()
        elif choice == 5:
            Menu.show()
        else:
            print("Error: Number out of range")
            self.showMenu()

    def showFiles(self):
        for _, _, files in os.walk(path): 
            i = 0
            for file in files:
                print('[%s]: ' %(i) + file)
                i += 1

    def makeZip(self):
        numbersOfFilesToArchieve = []

        print('Select a file(s) to archive. If you are done, just press Enter...\n')
        self.showFiles()

        while True:
            try:
                choice = input()

                if choice == '':
                    break

                choice = int(choice)
            except ValueError:
                print('\nError: Invalid number\n')
                continue
            except Exception as e:
                print('\nSomething went wrong... Error: %s' %(e))
                continue
            
            numbersOfFilesToArchieve.append(choice)
        
        zipFiles = []
        for _, _, files in os.walk(path): 
            i = 0
            for file in files:
                for number in numbersOfFilesToArchieve:
                    if i == number:
                        zipFiles.append(file)
                i += 1
        
        print('Enter a name of Zip archive')
        zipName = input()
        zipPath = '%s%s.zip' %(path, zipName)

        try:
            zipFile = zipfile.ZipFile(zipPath, 'w')
        except Exception as e:
            print('\nSomething went wrong... Error: %s' %(e))
            self.showMenu()
            return

        self.zipPath = zipPath

        for file in zipFiles:
            zipFile.write(file)

        print(zipFile.printdir())

        zipFile.close()

        self.showMenu()

    def unmakeZip(self):
        try:
            zipFile = zipfile.ZipFile(self.zipPath, 'r')
            zipFile.extractall('%sArchive' %(path))
            zipFile.close()
        except Exception as e:
            print('\nSomething went wrong... Error: %s' %(e))
            self.showMenu()
            return

        self.showMenu()

    def deleteZip(self):
        try:
            os.remove(self.zipPath)
        except Exception as e:
            print('\nSomething went wrong... Error: %s' %(e))
        
        self.showMenu()

Menu.show()
