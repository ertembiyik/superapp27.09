import SwiftUI
import DeckUI

struct ContentView: View {
    var body: some View {
        Presenter(deck: deck)
    }
    
    var deck: Deck {
        Deck(title: "Superapp 27.09") {
            Slide(alignment: .center) {
                Title("Directory traversal")
            }
            
            Slide(alignment: .center) {
                Title("Что и зачем?")
                
                Words("Directory traversal (обход директории) - уязвимость веб-безопасности которая позволяет злоумшленнику читать любые файлы, находящиеся на сервере исполняемой программы")
            }
            
            Slide(alignment: .center) {
                Title("Как использовать?")
                
                Words("В самом простом случае, разработчик сервиса не валидирует инпут и мы можем достать любой файл так, будто мы достаем картинку:")
                Code("https://insecure-website.com/image?filename=../../../etc/passwd")
                Words("\n")
                
                Words("Сайт может применять защиту от негодяев, например убирать \"../\" из инпута, тем самым не давая возможности подняться вверх по дереву файловой системы, но такакя защита не будет эффективной, тк мы можем заменить инпут на:")
                Code("....//....//....//etc/passwd")
                Words("\n")
                
                Words("Также делать проверку только на extension файла - не самая лучшая идея, злоумышленник может обойти ее с помощью null byte уязвимости например вот так:")
                Code("filename=../../../etc/passwd%00.png")
            }
            
            Slide(alignment: .center) {
                Title("Еще пример использования null byte:")
                Bullets(style: .dash) {
                    Words("An attacker wants to upload a malicious.php, but the only extension allowed is .pdf.")
                    Words("The attacker constructs the file name such as malicious.php%00.pdf and uploads the file.")
                    Words("The application reads the .pdf extension, validate the upload, and later throws the end of the string due to the null byte.")
                    Words("The file malicious.php is then put in the server.")
                }
            }
            
            Slide(alignment: .center) {
                Title("Как защититься?")
                Columns {
                    Column {
                        Bullets(style: .dash) {
                            Words("Закрыть прямой доступ из инпута юзера к апи файловой системы")
                            Words("Валидация инпута перед его исполнением (желателен whitelist c допустимыми значениями или, если это не возможно, то валидация на допустимых значениях, например что в инпуте только алфавит и цифры)")
                            Words("Проверить что конечный путь начинается с base directory")
                            Words("Ну и конечно не хранить пароли с фотографиями в одной директории")
                        }
                    }
                    Column {
                        Code("""
                             let file = File(with: Constants.baseDirectory, and: userInput)
                             if (file.canonicalPath.starts(with: Constants.baseDirectory) {
                                 // process file
                             }
                            """)
                    }
                }
            }
            
            Slide(alignment: .center) {
                Title("Что умеем по итогу?")
                Bullets(style: .dash) {
                    Words("Копаться в файлах незащищенных сайтов")
                    Words("Обходить простую защиту")
                    Words("Защищать свои проекты от таких казусов")
                    
                }
            }
            
            Slide(alignment: .center) {
                Title("Еще новости")
                Words("Ресерч на тему уменьшения времени запуска больших приложений:\nhttps://www.emergetools.com/blog/posts/improve-popular-iOS-app-startup-times")
                Words("")
            }
            
            Slide(alignment: .center) {
                Title("Swift 5.7")
                Code(#"""
                let clock = ContinuousClock()

                let time = clock.measure {
                    // complex work here
                }

                print(\"Took \(time.components.seconds) seconds\")
                """#)
                
                Code(#"""
                func createDiceRoll() -> () -> some View {
                    return {
                        let diceRoll = Int.random(in: 1...6)
                        return Text(String(diceRoll))
                    }
                }
                """#)
                
                Code(#"""
                let videos: [any Equatable] = ["Brooklyn", 99]
                """#)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
