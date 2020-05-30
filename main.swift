import Foundation
import Glibc

protocol CheckListElementProtocol{
    var czyDaSieWykonac:Bool {get set}
    func pokazCzyDaSieWykonac()
}

protocol CommunicationProtocol{
    func wydrukujElementy()
}

class CheckListElement: CheckListElementProtocol{
    var poleTekstowe:String
    var czyWykonany:Bool
    var dzienTygodnia:String
    var czyDaSieWykonac:Bool = false
    var delegate:CommunicationProtocol?
    
    
    
    init(){
        poleTekstowe = ""
        czyWykonany = false
        dzienTygodnia = ""
    }
    
    init(_ nrDniaTygodnia:Int, _ poleTekstowe:String, _ czyWykonany:Bool){
        self.poleTekstowe = poleTekstowe
        self.czyWykonany = czyWykonany
        let tydzien = ["Poniedziałek", "Wtorek", "Środa", "Czwartek", "Piątek", "Sobota", "Niedziela"]
        self.dzienTygodnia = tydzien[nrDniaTygodnia-1]
    }
    func pokazCzyDaSieWykonac(){
        if czyWykonany == true{
            czyDaSieWykonac = true
            print("da się wykonać")
        }
        else{
            czyDaSieWykonac = false
            print("niewiadomo, czy da się wykonać")
        }
    }
    func zmienCzyWykonany(){
        delegate?.wydrukujElementy()
        var holder:Bool?
        holder = czyWykonany
        if holder == true {
            czyWykonany = false
        }
        else{
            czyWykonany = true
        }
    }
}
   
extension CheckListElement: CustomStringConvertible{
    var description: String {
        var tekstCzyWykonany = ""
        if czyWykonany == false {
            tekstCzyWykonany = "Do Wykonania"
        }
        else{
            tekstCzyWykonany = "Gotowe"
        }
        return "\(dzienTygodnia) \(poleTekstowe) -> \(tekstCzyWykonany)"
    }   
}

class CheckList: CommunicationProtocol{
    var arrayCheckList:[CheckListElement]?
    
    init(_ arrayCheckList:[CheckListElement]){
        self.arrayCheckList = arrayCheckList
    }
    
    func wydrukujElementy(){
        for element in arrayCheckList!{
            print(element)
        }
    }
}


var a = CheckListElement(1, "Wyjść na spacer", true)
var b = CheckListElement(2, "Zrobić zakupy", false)
var c = CheckListElement(3, "Posprzątać pokój", true)
var d = CheckListElement(4, "Wyjść z psem", false)
var checkListElementArray = [a,b,c,d]
var test = CheckList(checkListElementArray)
a.delegate = test
a.zmienCzyWykonany()
a.zmienCzyWykonany()










