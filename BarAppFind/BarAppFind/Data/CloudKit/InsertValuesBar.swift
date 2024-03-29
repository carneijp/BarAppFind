//
//  InsertValuesBar.swift
//  BarAppFind
//
//  Created by Eduardo Riboli on 04/05/23.
//

import SwiftUI

struct InsertValuesBar {
    
    @StateObject var cloud = CloudKitCRUD()
    
    var nomes: [String] = ["Quentins", "Boteco Pedrini", "Réu Rango e Bira", "Brita", "Céu Bar e Arte", "El Aguante", "Espaço Barasco", "Bibah", "Armazem", "Bar do Osvaldo"]
    var latitudes: [Double] = [-30.040181010490798, -30.03736053756768, -30.034686004827947, -30.040944420631558, -30.044803976971046, -30.033459015263357, -30.0317770480045, -30.034102274800194, -30.03566772494728, -30.033612608086532]
    var longitudes: [Double] = [-51.21888666132587, -51.222716864275185, -51.226779559478764, -51.21833618668556, -51.21568220365493, -51.20590034783193, -51.210725417149476, -51.21290185947873, -51.21140817666721, -51.21433027116467]
    var descricao: [String] = ["Um bar Rock and Roll pra tu curtir com a tua galera 🤘 Chope | Drinks | Música | Tarantino", "Nada melhor que vir se divertir com seus amigos ou familiares aqui no Pedrini! 😄", "Muita comilança e muita bira 😋🍻", "🟠 Um espaço multicultural a céu aberto.", "A dona do melhor Caipão do sul do Brasil ✌️", "El aguante: Pela cultura democrática de botequim aguante! 👋 Venha curtir uns traguitos, croquetes y conservas!", "A sala de estar do Bom Fim ✨", "🍹 drinks na calçadinha favorita do Bom Fim 🌈 orgulho o ano inteiro", "Um lugar para conhecer uma variedade de bebidas enquanto aproveita o clima da redenção.", "Venha conhecer o famoso Samba do Osvaldo! 🎶"]
    
    var time: [OperationHours] = [OperationHours(barName: "Quentins", monday: "Fechado", tuesday: "18:00-23:30", wednesday: "18:00-23:30", thrusday: "18:00-00:00", friday: "18:00-00:00", saturday: "18:00-00:00", sunday: "18:00-00:00"), OperationHours(barName: "Boteco Pedrini", monday: "16:00-03:00", tuesday: "16:00-03:00", wednesday: "16:00-04:00", thrusday: "16:00-04:00", friday: "16:00-05:00", saturday: "16:00-05:00", sunday: "16:00-03:00"), OperationHours(barName: "Réu Rango e Bira", monday: "Fechado", tuesday: "17:00-00:00", wednesday: "17:00-00:00", thrusday: "17:00-00:00", friday: "17:00-00:00", saturday: "17:00-00:00", sunday: "17:00-00:00"), OperationHours(barName: "Brita", monday: "Fechado", tuesday: "Fechado", wednesday: "18:00-00:00", thrusday: "18:00-00:00", friday: "18:00-01:30", saturday: "18:00-01:30", sunday: "17:00-00:00"), OperationHours(barName: "Céu Bar e Arte", monday: "Fechado", tuesday: "18:00-00:00", wednesday: "18:00-00:00", thrusday: "18:00-00:00", friday: "18:00-01:00", saturday: "18:00-01:00", sunday: "18:00-00:00"), OperationHours(barName: "El Aguante", monday: "Fechado", tuesday: "17:00-23:00", wednesday: "17:00-23:00", thrusday: "17:00-23:00", friday: "16:00-23:00", saturday: "17:00-23:00", sunday: "Fechado"), OperationHours(barName: "Espaço Barasco", monday: "07:30-22:00", tuesday: "07:30-22:00", wednesday: "07:30-22:00", thrusday: "07:30-22:00", friday: "07:30-22:00", saturday: "07:30-22:00", sunday: "07:30-22:00"), OperationHours(barName: "Bibah", monday: "15:00-23:00", tuesday: "15:00-23:00", wednesday: "15:00-23:00", thrusday: "15:00-00:00", friday: "15:00-00:00", saturday: "15:00-00:00", sunday: "15:00-21:00"), OperationHours(barName: "Armazem", monday: "18:00-23:00", tuesday: "18:00-23:00", wednesday: "18:00-23:00", thrusday: "18:00-23:00", friday: "18:00-23:00", saturday: "18:00-23:00", sunday: "18:00-23:00"), OperationHours(barName: "Bar do Osvaldo", monday: "Fechado", tuesday: "18:00-00:00", wednesday: "18:00-00:00", thrusday: "18:00-00:00", friday: "19:00-01:00", saturday: "19:00-01:00", sunday: "Fechado")]
                
    func loadBars(){
            for i in 0...nomes.count{
//                cloud.addBar(bar: Bar(name: nomes[i], latitude: latitudes[i], longitude: latitudes[i], mood: mood[i], description: descricao[i]))
            }
        }
}
