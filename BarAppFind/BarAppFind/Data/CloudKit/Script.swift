////
////  InsertValuesBar.swift
////  BarAppFind
////
////  Created by Eduardo Riboli on 04/05/23.
////
//
//import SwiftUI
//
//struct InsertValuesBar {
//    @EnvironmentObject var cloud: CloudKitCRUD
//    
//    
//    var nomes: [String] = ["Quentins", "Boteco Pedrini", "Réu Rango e Bira", "Brita", "Céu Bar e Arte", "El Aguante", "Espaço Barasco", "Bibah", "Armazem", "Bar do Osvaldo"]
//    var latitudes: [Double] = [-30.040181010490798, -30.03736053756768, -30.034686004827947, -30.040944420631558, -30.044803976971046, -30.033459015263357, -30.0317770480045, -30.034102274800194, -30.03566772494728, -30.033612608086532]
//    var longitudes: [Double] = [-51.21888666132587, -51.222716864275185, -51.226779559478764, -51.21833618668556, -51.21568220365493, -51.20590034783193, -51.210725417149476, -51.21290185947873, -51.21140817666721, -51.21433027116467]
//    var descricao: [String] = ["Um bar Rock and Roll pra tu curtir com a tua galera 🤘 Chope | Drinks | Música | Tarantino",
//                               "Nada melhor que vir se divertir com seus amigos ou familiares aqui no Pedrini! 😄",
//                               "Muita comilança e muita bira 😋🍻",
//                               "🟠 Um espaço multicultural a céu aberto.",
//                               "A dona do melhor Caipão do sul do Brasil ✌️",
//                               
//                               "El aguante: Pela cultura democrática de botequim aguante! 👋 Venha curtir uns traguitos, croquetes y conservas!",
//                               "A sala de estar do Bom Fim ✨",
//                               "🍹 drinks na calçadinha favorita do Bom Fim 🌈 orgulho o ano inteiro",
//                               "Um lugar para conhecer uma variedade de bebidas enquanto aproveita o clima da redenção.",
//                               "Venha conhecer o famoso Samba do Osvaldo! 🎶"]
//    
//    var time: [[String]] = [
//        ["monday: Fechado", "tuesday: 18:00-23:30", "wednesday: 18:00-23:30", "thrusday: 18:00-00:00", "friday: 18:00-00:00", "saturday: 18:00-00:00", "sunday: 18:00-00:00"],
//        ["monday: 16:00-03:00", "tuesday: 16:00-03:00", "wednesday: 16:00-04:00", "thrusday: 16:00-04:00", "friday: 16:00-05:00", "saturday: 16:00-05:00", "sunday: 16:00-03:00"],
//        ["monday: Fechado", "tuesday: 17:00-00:00", "wednesday: 17:00-00:00", "thrusday: 17:00-00:00", "friday: 17:00-00:00", "saturday: 17:00-00:00", "sunday: 17:00-00:00"],
//        ["monday: Fechado", "tuesday: Fechado", "wednesday: 18:00-00:00", "thrusday: 18:00-00:00", "friday: 18:00-01:30", "saturday: 18:00-01:30", "sunday: 17:00-00:00"],
//        ["monday: Fechado", "tuesday: 18:00-00:00", "wednesday: 18:00-00:00", "thrusday: 18:00-00:00", "friday: 18:00-01:00", "saturday: 18:00-01:00", "sunday: 18:00-00:00"],
//        ["monday: Fechado", "tuesday: 17:00-23:00", "wednesday: 17:00-23:00", "thrusday: 17:00-23:00", "friday: 16:00-23:00", "saturday: 17:00-23:00", "sunday: Fechado"],
//        ["monday: 07:30 - 22:00", "uesday: 07:30 - 22:00", "wednesday: 07:30 - 22:00", "thrusday: 07:30 - 22:00", "friday: 07:30 - 22:00", "saturday: 07:30 - 22:00", "sunday: 07:30 - 22:00"],
//        ["monday: 15:00-23:00", "tuesday: 15:00-23:00", "wednesday: 15:00-23:00", "thrusday: 15:00-00:00", "friday: 15:00-00:00", "saturday: 15:00-00:00", "sunday: 15:00-21:00"],
//        ["monday: 18:00-23:00", "tuesday: 18:00-23:00", "wednesday: 18:00-23:00", "thrusday: 18:00-23:00", "friday: 18:00-23:00", "saturday: 18:00-23:00", "sunday: 18:00-23:00"],
//        ["monday: Fechado", "tuesday: 18:00-00:00", "wednesday: 18:00-00:00", "thrusday: 18:00-00:00", "friday: 19:00-01:00", "saturday: 19:00-01:00", "sunday: Fechado"]
//    ]
//    
//    func loadBars(){
//        var quentins: Bar = Bar(name: "Quentins", description: "Um bar Rock and Roll pra tu curtir com a tua galera 🤘 Chope | Drinks | Música | Tarantino", mood: ["Ambientes temáticos"], grade: 5.0, latitude: -30.040181010490798, longitude: -51.21888666132587, operatinhours: ["monday: Fechado", "tuesday: 18:00-23:30", "wednesday: 18:00-23:30", "thrusday: 18:00-00:00", "friday: 18:00-00:00", "saturday: 18:00-00:00", "sunday: 18:00-00:00"], endereco: "R. General Lima e Silva, 918 - Centro Histórico, Porto Alegre", regiao: "Cidade Baixa", caracteristicas: ["Estacionamento", "Aceita PET"])
//        quentins.recieveAllPhotos(photosToSAVE: ["Quentins1", "Quentins2", "Quentins3"])
//        quentins.photoLogoTOSave = "Quentins"
//        cloud.addBar(bar: quentins )
//        
//        var pedrinho: Bar = Bar(name: "Boteco Pedrini", description: "Nada melhor que vir se divertir com seus amigos ou familiares aqui no Pedrini! 😄", mood: ["Family friendly"], grade: 5.0, latitude: -30.03736053756768, longitude: -51.222716864275185, operatinhours: ["monday: 16:00-03:00", "tuesday: 16:00-03:00", "wednesday: 16:00-04:00", "thrusday: 16:00-04:00", "friday: 16:00-05:00", "saturday: 16:00-05:00", "sunday: 16:00-03:00"], endereco: "R. Gen. Lima e Silva, 431 - Cidade Baixa, Porto Alegre", regiao: "Cidade Baixa", caracteristicas: ["Estacionamento"])
//        pedrinho.recieveAllPhotos(photosToSAVE: ["Pedrini1", "Pedrini2", "Pedrini3"])
//        pedrinho.photoLogoTOSave = "Pedrini"
//        cloud.addBar(bar: pedrinho )
//        
//        var bira: Bar = Bar(name: "Réu Rango e Bira", description: "Muita comilança e muita bira 😋🍻", mood: ["Fofoca", "Barzinho", "Family friendly"], grade: 5.0, latitude: -30.034686004827947, longitude: -51.226779559478764, operatinhours: ["monday: Fechado", "tuesday: 17:00-00:00", "wednesday: 17:00-00:00", "thrusday: 17:00-00:00", "friday: 17:00-00:00", "saturday: 17:00-00:00", "sunday: 17:00-00:00"], endereco: "R. Cel. Fernando Machado, 1168 - Centro Histórico, Porto Alegre" , regiao: "Cidade Baixa", caracteristicas: ["Estacionamento"])
//        bira.recieveAllPhotos(photosToSAVE: ["RReBira1", "RReBira2", "RReBira3"])
//        bira.photoLogoTOSave = "RReBira"
//        cloud.addBar(bar: bira )
//        
//        var brita: Bar = Bar(name: "Brita", description: "🟠 Um espaço multicultural a céu aberto.", mood: ["Fofoca", "Barzinho", "Esquenta", "Role de casal"], grade: 5.0, latitude: -30.040944420631558, longitude: -51.21833618668556, operatinhours: ["monday: Fechado", "tuesday: Fechado", "wednesday: 18:00-00:00", "thrusday: 18:00-00:00", "friday: 18:00-01:30", "saturday: 18:00-01:30", "sunday: 17:00-00:00"], endereco: "R. Gen. Lima e Silva, 1037 - Centro Histórico, Porto Alegre", regiao: "Cidade Baixa", caracteristicas: ["Estacionamento"])
//        brita.recieveAllPhotos(photosToSAVE: ["Brita1", "Brita2", "Brita3"])
//        brita.photoLogoTOSave = "Brita"
//        cloud.addBar(bar: brita)
//        
//        var ceu: Bar = Bar(name: "Céu Bar e Arte", description: "A dona do melhor Caipão do sul do Brasil ✌️", mood: ["Esquenta", "Fofoca", "Barzinho", "Familu friendly"], grade: 5.0, latitude: -30.044803976971046, longitude:  -51.21568220365493, operatinhours: ["monday: Fechado", "tuesday: 18:00-00:00", "wednesday: 18:00-00:00", "thrusday: 18:00-00:00", "friday: 18:00-01:00", "saturday: 18:00-01:00", "sunday: 18:00-00:00"], endereco: "R. General Lima e Silva, 1487 - Azenha, Porto Alegre", regiao: "", caracteristicas: ["Estacionamento"])
//        ceu.recieveAllPhotos(photosToSAVE: ["Ceu1", "Ceu2", "Ceu3"])
//        ceu.photoLogoTOSave = "Ceu"
//        cloud.addBar(bar: ceu)
//        
//        var agante: Bar =  Bar(name: "El Aguante", description: "El aguante: Pela cultura democrática de botequim aguante! 👋 Venha curtir uns traguitos, croquetes y conservas!", mood: ["Barzinho", "Fofoca", "Esquenta", "Role de casal"], grade: 5.0, latitude: -30.033459015263357, longitude: -51.20590034783193, operatinhours: ["monday: Fechado", "tuesday: 17:00-23:00", "wednesday: 17:00-23:00", "thrusday: 17:00-23:00", "friday: 16:00-23:00", "saturday: 17:00-23:00", "sunday: Fechado"], endereco: "R. Miguel Tostes, 611 - Rio Branco, Porto Alegre", regiao: "Bom Fim", caracteristicas: ["Estacionamento"])
//        agante.recieveAllPhotos(photosToSAVE: ["ElAguante1", "ElAguante2"])
//        agante.photoLogoTOSave = "ElAguante"
//        cloud.addBar(bar: agante)
//        
//        var brasco: Bar =  Bar(name: "Espaço Brasco", description: "A sala de estar do Bom Fim ✨", mood: ["Barzinho", "Fofoca", "Family friendly"], grade: 5.0, latitude: -30.0317770480045, longitude: -51.210725417149476, operatinhours: ["monday: 07:30 - 22:00", "uesday: 07:30 - 22:00", "wednesday: 07:30 - 22:00", "thrusday: 07:30 - 22:00", "friday: 07:30 - 22:00", "saturday: 07:30 - 22:00", "sunday: 07:30 - 22:00"], endereco: "Rua Fernandes Vieira, 286 - Bom Fim, Porto Alegre", regiao: "Bom Fim", caracteristicas: ["Estacionamento"])
//        brasco.recieveAllPhotos(photosToSAVE: ["EspacoBarasco1", "EspacoBarasco2", "EspacoBarasco3"])
//        brasco.photoLogoTOSave = "Brasco"
//        cloud.addBar(bar: brasco)
//        
//        var bibah: Bar = Bar(name: "Bibah", description: "🍹 drinks na calçadinha favorita do Bom Fim 🌈 orgulho o ano inteiro", mood: ["Ambiente temático", "Fofoca"], grade: 5.0, latitude: -30.034102274800194, longitude: -51.21290185947873, operatinhours: ["monday: 15:00-23:00", "tuesday: 15:00-23:00", "wednesday: 15:00-23:00", "thrusday: 15:00-00:00", "friday: 15:00-00:00", "saturday: 15:00-00:00", "sunday: 15:00-21:00"], endereco: "Rua General João Telles, 531 - Bom Fim, Porto Alegre", regiao: "Bom Fim", caracteristicas: ["Estacionamento"])
//        bibah.recieveAllPhotos(photosToSAVE: ["BibahBar1", "BibahBar2", "BibahBar3"])
//        bibah.photoLogoTOSave = "Bibah"
//        cloud.addBar(bar: bibah)
//        
//        var armazem: Bar = Bar(name: "Armazem", description: "Um lugar para conhecer uma variedade de bebidas enquanto aproveita o clima da redenção.", mood: ["Barzinho, Fofoca, Family friendly, Esquenta, Role de casal"], grade: 5.0, latitude: -30.03566772494728, longitude: -51.21140817666721, operatinhours: ["monday: 18:00-23:00", "tuesday: 18:00-23:00", "wednesday: 18:00-23:00", "thrusday: 18:00-23:00", "friday: 18:00-23:00", "saturday: 18:00-23:00", "sunday: 18:00-23:00"], endereco: "Avenida Borges de Medeiros, Viaduto Otávio Rocha, 786 - Centro Histórico, Porto Alegre", regiao: "Cidade Baixa", caracteristicas: ["Estacionamento"])
//        armazem.recieveAllPhotos(photosToSAVE: ["Armazem1", "Armazem2", "Armazem3"])
//        armazem.photoLogoTOSave = "Armazem"
//        cloud.addBar(bar: armazem)
//        
//        var osvaldo: Bar = Bar(name: "Bar do osvaldo", description: "Venha conhecer o famoso Samba do Osvaldo! 🎶", mood: ["Esquenta", "Role de casal"], grade: 5.0, latitude: -30.033612608086532, longitude: -51.21433027116467, operatinhours: ["monday: Fechado", "tuesday: 18:00-00:00", "wednesday: 18:00-00:00", "thrusday: 18:00-00:00", "friday: 19:00-01:00", "saturday: 19:00-01:00", "sunday: Fechado"], endereco: "Av. Osvaldo Aranha, 784 - Bom Fim, Porto Alegre", regiao: "Bom Fim", caracteristicas: ["Estacionamento"])
//        osvaldo.recieveAllPhotos(photosToSAVE: ["Osvaldo1", "Osvaldo2"])
//        osvaldo.photoLogoTOSave = "Osvaldo"
//        cloud.addBar(bar: osvaldo)
//    }
//}
