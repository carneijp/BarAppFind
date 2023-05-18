//
//  InsertValuesBar.swift
//  BarAppFind
//
//  Created by Eduardo Riboli on 04/05/23.
//

import SwiftUI
import Foundation

struct ScriptProfile: View{
    var body: some View{
        Button{
            
        }label: {
            Image(systemName: "star")
        }
    }
}


struct InsertValuesBar {
    @EnvironmentObject var cloud: CloudKitCRUD
    var nomes: [String] = ["Quentins", "Boteco Pedrini", "Réu Rango e Bira", "Brita", "Céu Bar e Arte", "El Aguante", "Espaço Barasco", "Bibah", "Armazem", "Bar do Osvaldo"]
    var latitudes: [Double] = [-30.040181010490798, -30.03736053756768, -30.034686004827947, -30.040944420631558, -30.044803976971046, -30.033459015263357, -30.0317770480045, -30.034102274800194, -30.03566772494728, -30.033612608086532]
    var longitudes: [Double] = [-51.21888666132587, -51.222716864275185, -51.226779559478764, -51.21833618668556, -51.21568220365493, -51.20590034783193, -51.210725417149476, -51.21290185947873, -51.21140817666721, -51.21433027116467]
    var descricao: [String] = ["Um bar Rock and Roll pra tu curtir com a tua galera 🤘 Chope | Drinks | Música | Tarantino",
                               "Nada melhor que vir se divertir com seus amigos ou familiares aqui no Pedrini! 😄",
                               "Muita comilança e muita bira 😋🍻",
                               "🟠 Um espaço multicultural a céu aberto.",
                               "A dona do melhor Caipão do sul do Brasil ✌️",
                               
                               "El aguante: Pela cultura democrática de botequim aguante! 👋 Venha curtir uns traguitos, croquetes y conservas!",
                               "A sala de estar do Bom Fim ✨",
                               "🍹 drinks na calçadinha favorita do Bom Fim 🌈 orgulho o ano inteiro",
                               "Um lugar para conhecer uma variedade de bebidas enquanto aproveita o clima da redenção.",
                               "Venha conhecer o famoso Samba do Osvaldo! 🎶"]
    
    var time: [[String]] = [
        ["Segunda: Fechado", "Terça: 18h - 23h30", "Quarta: 18h - 23h30", "Quinta: 18h - 00h", "Sexta: 18h - 00h", "Sábado: 18h - 00h", "Domingo: 18h - 00h"],
        ["Segunda: 16h - 03h", "Terça: 16h - 03h", "Quarta: 16h - 04h", "Quinta: 16h - 04h", "Sexta: 16h - 05h", "Sábado: 16h - 05h", "Domingo: 16h - 03h"],
        ["Segunda: Fechado", "Terça: 17h - 00h", "Quarta: 17h - 00h", "Quinta: 17h - 00h", "Sexta: 17h - 00h", "Sábado: 17h - 00h", "Domingo: 17h - 00h"],
        ["Segunda: Fechado", "Terça: Fechado", "Quarta: 18h - 00h", "Quinta: 18h - 00h", "Sexta: 18h - 01h30", "Sábado: 18h - 01h30", "Domingo: 17h - 00h"],
        ["Segunda: Fechado", "Terça: 18h - 00h", "Quarta: 18h - 00h", "Quinta: 18h - 00h", "Sexta: 18h - 01h", "Sábado: 18:00-01:00", "Domingo: 18:00-00:00"],
        ["Segunda: Fechado", "Terça: 17h - 23h", "Quarta: 17h - 23h", "Quinta: 17h - 23h", "Sexta: 16h - 23h", "Sábado: 17h - 23h", "Domingo: Fechado"],
        ["Segunda: 07h30 - 22h", "Terça: 07h30 - 22h", "Quarta: 07h30 - 22h", "Quinta: 07h30 - 22h", "Sexta: 07h30 - 22h", "Sábado: 07h30 - 22h", "Domingo: 07h30 - 22h"],
        ["Segunda: 15h - 23h", "Terça: 15h - 23h", "Quarta: 15h - 23h", "Quinta: 15h - 00h", "Sexta: 15h - 00h", "Sábado: 15h - 00h", "Domingo: 15h - 21h"],
        ["Segunda: 18h - 23h", "Terça: 18h - 23h", "Quarta: 18h - 23h", "Quinta: 18h - 23h", "Sexta: 18h - 23h", "Sábado: 18h - 23h", "Domingo: 18h - 23h"],
        ["Segunda: Fechado", "Terça: 18h - 00h", "Quarta: 18h - 00h", "Quinta: 18h - 00h", "Sexta: 19h - 01h", "Sábado: 19h - 01h", "Domingo: Fechado"]
    ]
    
    func loadBars(){
        var quentins: Bar = Bar(name: "Quentins", description: "Um bar Rock and Roll pra tu curtir com a tua galera 🤘 Chope | Drinks | Música | Tarantino", mood: ["Temático"], grade: 5.0, latitude: -30.040181010490798, longitude: -51.21888666132587, operatinhours: ["Segunda: Fechado", "Terça: 18h - 23h30", "Quarta: 18h - 23h30", "Quinta: 18h - 00h", "Sexta: 18h - 00h", "Sábado: 18h - 00h", "Domingo: 18h - 00h"], endereco: "R. General Lima e Silva, 918 - Centro Histórico, Porto Alegre", regiao: "Cidade Baixa", caracteristicas: ["Climatizado", "Wifi"])
        quentins.recieveAllPhotos(photosToSAVE: ["Quentins"])
        quentins.photoLogoTOSave = "QuentinsLogo"
        quentins.linktInsta = "https://www.instagram.com/quentinsbar/?igshid=MzRlODBiNWFlZA%3D%3D"
        cloud.addBar(bar: quentins){}
        
        var pedrinho: Bar = Bar(name: "Boteco Pedrini", description: "Nada melhor que vir se divertir com seus amigos ou familiares aqui no Pedrini! 😄", mood: ["Família"], grade: 5.0, latitude: -30.03736053756768, longitude: -51.222716864275185, operatinhours: ["Segunda: 16h - 03h", "Terça: 16h - 03h", "Quarta: 16h - 04h", "Quinta: 16h - 04h", "Sexta: 16h - 05h", "Sábado: 16h - 05h", "Domingo: 16h - 03h"], endereco: "R. Gen. Lima e Silva, 431 - Cidade Baixa, Porto Alegre", regiao: "Cidade Baixa", caracteristicas: ["Ao ar livre", "Madrugada", "Climatizado", "Wifi", "Permitido fumar", "Sinuca"])
        pedrinho.recieveAllPhotos(photosToSAVE: ["Pedrini"])
        pedrinho.photoLogoTOSave = "PedriniLogo"
        pedrinho.linktInsta = "https://www.instagram.com/botecopedrini/?igshid=ZWIzMWE5ZmU3Zg%3D%3D"
        cloud.addBar(bar: pedrinho){}
        
        var bira: Bar = Bar(name: "Réu Rango e Bira", description: "Muita comilança e muita bira 😋🍻", mood: ["Fofoca", "Barzinho", "Família"], grade: 5.0, latitude: -30.034686004827947, longitude: -51.226779559478764, operatinhours: ["Segunda: Fechado", "Terça: 17h - 00h", "Quarta: 17h - 00h", "Quinta: 17h - 00h", "Sexta: 17h - 00h", "Sábado: 17h - 00h", "Domingo: 17h - 00h"], endereco: "R. Cel. Fernando Machado, 1168 - Centro Histórico, Porto Alegre" , regiao: "Cidade Baixa", caracteristicas: ["Climatizado", "Ao ar livre", "Aceita pets"])
        bira.recieveAllPhotos(photosToSAVE: ["Reu"])
        bira.photoLogoTOSave = "ReuLogo"
        bira.linktInsta = "https://www.instagram.com/reuyeah/?igshid=MzRlODBiNWFlZA%3D%3D"
        cloud.addBar(bar: bira){}
        
        var brita: Bar = Bar(name: "Brita", description: "🟠 Um espaço multicultural a céu aberto.", mood: ["Fofoca", "Barzinho", "Casal"], grade: 5.0, latitude: -30.040944420631558, longitude: -51.21833618668556, operatinhours: ["Segunda: Fechado", "Terça: Fechado", "Quarta: 18h - 00h", "Quinta: 18h - 00h", "Sexta: 18h - 01h30", "Sábado: 18h - 01h30", "Domingo: 17h - 00h"], endereco: "R. Gen. Lima e Silva, 1037 - Centro Histórico, Porto Alegre", regiao: "Cidade Baixa", caracteristicas: ["Ao ar livre", "Aceita pets", "Madrugada", "Permitido fumar"])
        brita.recieveAllPhotos(photosToSAVE: ["Brita"])
        brita.photoLogoTOSave = "BritaLogo"
        brita.linktInsta = "https://www.instagram.com/britapoa/?igshid=MzRlODBiNWFlZA%3D%3D"
        cloud.addBar(bar: brita){}
        
        var ceu: Bar = Bar(name: "Céu Bar e Arte", description: "A dona do melhor Caipão do sul do Brasil ✌️", mood: ["Esquenta", "Barzinho", "Família"], grade: 5.0, latitude: -30.044803976971046, longitude:  -51.21568220365493, operatinhours: ["Segunda: Fechado", "Terça: 18h - 00h", "Quarta: 18h - 00h", "Quinta: 18h - 00h", "Sexta: 18h - 01h", "Sábado: 18:00-01:00", "Domingo: 18:00-00:00"], endereco: "R. General Lima e Silva, 1487 - Azenha, Porto Alegre", regiao: "", caracteristicas: ["Climatizado", "Ao ar livre", "Madrugada", "Wifi", "Permitido fumar"])
        ceu.recieveAllPhotos(photosToSAVE: ["Ceu"])
        ceu.photoLogoTOSave = "CeuLogo"
        ceu.linktInsta = "https://www.instagram.com/ceubarearte/?igshid=MzRlODBiNWFlZA%3D%3D"
        cloud.addBar(bar: ceu){}
        
        var agante: Bar =  Bar(name: "El Aguante", description: "El aguante: Pela cultura democrática de botequim aguante! 👋 Venha curtir uns traguitos, croquetes y conservas!", mood: ["Barzinho", "Fofoca", "Casal"], grade: 5.0, latitude: -30.033459015263357, longitude: -51.20590034783193, operatinhours: ["Segunda: Fechado", "Terça: 17h - 23h", "Quarta: 17h - 23h", "Quinta: 17h - 23h", "Sexta: 16h - 23h", "Sábado: 17h - 23h", "Domingo: Fechado"], endereco: "R. Miguel Tostes, 611 - Rio Branco, Porto Alegre", regiao: "Bom Fim", caracteristicas: ["Ao ar livre", "Aceita pets", "Permitido fumar"])
        agante.recieveAllPhotos(photosToSAVE: ["ElAguante"])
        agante.photoLogoTOSave = "ElAguanteLogo"
        agante.linktInsta = "https://www.instagram.com/elaguantebar/?igshid=MzRlODBiNWFlZA%3D%3D"
        cloud.addBar(bar: agante){}
        
        var brasco: Bar =  Bar(name: "Espaço Brasco", description: "A sala de estar do Bom Fim ✨", mood: ["Barzinho", "Fofoca", "Família"], grade: 5.0, latitude: -30.0317770480045, longitude: -51.210725417149476, operatinhours: ["Segunda: 07h30 - 22h", "Terça: 07h30 - 22h", "Quarta: 07h30 - 22h", "Quinta: 07h30 - 22h", "Sexta: 07h30 - 22h", "Sábado: 07h30 - 22h", "Domingo: 07h30 - 22h"], endereco: "Rua Fernandes Vieira, 286 - Bom Fim, Porto Alegre", regiao: "Bom Fim", caracteristicas: ["Climatizado", "Aceita pets", "Wifi", "Permitido fumar", "Ao ar livre"])
        brasco.recieveAllPhotos(photosToSAVE: ["Brasco"])
        brasco.photoLogoTOSave = "BrascoLogo"
        brasco.linktInsta = "https://www.instagram.com/espacobrasco/?igshid=MzRlODBiNWFlZA%3D%3D"
        cloud.addBar(bar: brasco){}
        
        var bibah: Bar = Bar(name: "Bibah", description: "🍹 drinks na calçadinha favorita do Bom Fim 🌈 orgulho o ano inteiro", mood: ["Temático", "Fofoca"], grade: 5.0, latitude: -30.034102274800194, longitude: -51.21290185947873, operatinhours: ["Segunda: 15h - 23h", "Terça: 15h - 23h", "Quarta: 15h - 23h", "Quinta: 15h - 00h", "Sexta: 15h - 00h", "Sábado: 15h - 00h", "Domingo: 15h - 21h"], endereco: "Rua General João Telles, 531 - Bom Fim, Porto Alegre", regiao: "Bom Fim", caracteristicas: ["Ao ar livre", "Permitido fumar", "Aceita pets"])
        bibah.recieveAllPhotos(photosToSAVE: ["Bibah"])
        bibah.photoLogoTOSave = "BibahLogo"
        bibah.linktInsta = "https://www.instagram.com/bibahpoa/?igshid=MzRlODBiNWFlZA%3D%3D"
        cloud.addBar(bar: bibah){}
        
        var armazem: Bar = Bar(name: "Armazem", description: "Um lugar para conhecer uma variedade de bebidas enquanto aproveita o clima da redenção.", mood: ["Fofoca", "Família", "Casal"], grade: 5.0, latitude: -30.03566772494728, longitude: -51.21140817666721, operatinhours: ["Segunda: 18h - 23h", "Terça: 18h - 23h", "Quarta: 18h - 23h", "Quinta: 18h - 23h", "Sexta: 18h - 23h", "Sábado: 18h - 23h", "Domingo: 18h - 23h"], endereco: "Avenida Borges de Medeiros, Viaduto Otávio Rocha, 786 - Centro Histórico, Porto Alegre", regiao: "Cidade Baixa", caracteristicas: ["Ao ar livre", "Permitido fumar", "Aceita pets"])
        armazem.recieveAllPhotos(photosToSAVE: ["Armazem"])
        armazem.photoLogoTOSave = "ArmazemLogo"
        armazem.linktInsta = "https://www.instagram.com/armazempoa/?igshid=MzRlODBiNWFlZA%3D%3D"
        cloud.addBar(bar: armazem){}
        
        var osvaldo: Bar = Bar(name: "Bar do osvaldo", description: "Venha conhecer o famoso Samba do Osvaldo! 🎶", mood: ["Esquenta", "Casal"], grade: 5.0, latitude: -30.033612608086532, longitude: -51.21433027116467, operatinhours: ["Segunda: Fechado", "Terça: 18h - 00h", "Quarta: 18h - 00h", "Quinta: 18h - 00h", "Sexta: 19h - 01h", "Sábado: 19h - 01h", "Domingo: Fechado"], endereco: "Av. Osvaldo Aranha, 784 - Bom Fim, Porto Alegre", regiao: "Bom Fim", caracteristicas: ["Ao ar livre", "Permitido fumar", "Aceita pets", "Wifi", "Climatizado", "Madrugada", "Sinuca"])
        osvaldo.recieveAllPhotos(photosToSAVE: ["OsvaldoBar"])
        osvaldo.photoLogoTOSave = "OsvaldoBarLogo"
        osvaldo.linktInsta = "https://www.instagram.com/osvaldo_barpoa/?igshid=MzRlODBiNWFlZA%3D%3D"
        cloud.addBar(bar: osvaldo){}
        
        var maza: Bar = Bar(name: "Bar Maza", description: "Um bar proximo a PUCRS para relaxar e fofocar com os amigos.🎶", mood: ["Esquenta", "Barzinho", "Fofoca"], grade: 5.0, latitude: -30.06219, longitude: -51.17451, operatinhours: ["Segunda: Fechado", "Terça: 18h - 00h", "Quarta: 18h - 00h", "Quinta: 18h - 00h", "Sexta: 19h - 01h", "Sábado: 19h - 01h", "Domingo: Fechado"], endereco: "Avenida Bento Gonçalves, 4169 - Vila Joao Pessoa, Porto Alegre", regiao: "Partenon", caracteristicas: ["Sinuca", "Ao ar livre", "Permitido fumar"])
        maza.recieveAllPhotos(photosToSAVE: ["Maza"])
        maza.photoLogoTOSave = "MazaLogo"
        maza.linktInsta = "https://www.instagram.com/mazabar_/?igshid=ZWIzMWE5ZmU3Zg%3D%3D"
        cloud.addBar(bar: maza){}
        
        var canto: Bar = Bar(name: "Canto Bar", description: "Um bar preto no branco, com um DNA cheio de cor🧬.", mood: ["Barzinho", "Esquenta", "Fofoca"], grade: 5.0, latitude: -30.01511, longitude: -51.20909, operatinhours: ["Segunda: Fechado", "Terça: Fechado", "Quarta: Fechado","Quinta: 18h - 00h","Sexta: 18h - 00h","Sabado: 18h - 00h","Domingo: Fechado"], endereco: "R. Álvaro Chaves, 350 - Floresta, Porto Alegre", regiao: "Quarto distrito", caracteristicas: ["Climatizado", "Ao ar livre", "Permitido fumar"])
        canto.recieveAllPhotos(photosToSAVE: ["Canto"])
        canto.photoLogoTOSave = "CantoLogo"
        canto.linktInsta = "https://www.instagram.com/cantobar_/?igshid=MzRlODBiNWFlZA%3D%3D"
        cloud.addBar(bar: canto){}
        
        var patrimonio: Bar = Bar(name: "Patrimonio", description: "Um lugar de ser feliz✨", mood: ["Barzinho", "Fofca", "Esquenta"], grade: 5.0, latitude: -30.01046, longitude: -51.20875, operatinhours: ["Segunda: Fechado", "Terça: Fechado", "Quarta: 18h - 23h45", "Quinta: 18h - 23h45", "Sexta: 18h - 23h45", "Sabado: 17h - 23h45", "Domingo: 17h - 23h45"], endereco: "R. Conselheiro Camargo, 212 - São Geraldo, Porto Alegre", regiao: "Quarto distrito", caracteristicas: ["Climatizado", "Ao ar livre", "Permitido fumar"])
        patrimonio.recieveAllPhotos(photosToSAVE: ["Patrimonio"])
        patrimonio.photoLogoTOSave = "PatrimonioLogo"
        patrimonio.linktInsta = "https://www.instagram.com/opatrimonio/?igshid=MzRlODBiNWFlZA%3D%3D"
        cloud.addBar(bar: patrimonio){}
        
        var deusa: Bar = Bar(name: "Deusa bar", description: "Sejam bem deusas🌈", mood: ["Família", "Fofoca", "Rolê de casal"], grade: 5.0, latitude: -30.03430, longitude: -51.21283, operatinhours: ["Segunda: Fechado", "Terça: Fechado", "Quarta: Fechado", "Quinta: 18h - 00h", "Sexta: 18h - 00h", "Sabado: 18h - 00h", "Domingo: Fechado"], endereco: "Rua General João Telles, 541 - Bom Fim, Porto Alegre", regiao: "Bom Fim", caracteristicas: ["Ao ar livre", "Permitido Fumar"])
        deusa.recieveAllPhotos(photosToSAVE: ["Deusa"])
        deusa.photoLogoTOSave = "DeusaLogo"
        deusa.linktInsta = "https://www.instagram.com/deusabar/"
        cloud.addBar(bar: deusa){}
    }
    
    func getDateOfWeek() -> String {
        let index = Calendar.current.component(.weekday, from: Date()) // this returns an Int
        let weekday: String = Calendar.current.weekdaySymbols[index - 1]
        
        return weekday
    }
    
//    let index = Foundation.Calendar.current.component(.weekday, from: Date()) // this returns an Int
//    func Calendar.current.weekdaySymbols[index - 1] // subtract 1 since the index starts at 1
}
