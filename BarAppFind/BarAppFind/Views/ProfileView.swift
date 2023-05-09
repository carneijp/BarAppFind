//
//  Profile.swift
//  BarAppFind
//
//  Created by Joao Paulo Carneiro on 29/04/23.
//

import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var cloud: CloudKitCRUD
    var body: some View {
        VStack{
            Button{
                var bares:[Bar] = []
                var quentins: Bar = Bar(name: "Quentins", description: "Um bar Rock and Roll pra tu curtir com a tua galera 🤘 Chope | Drinks | Música | Tarantino", mood: ["Ambientes temáticos"], grade: 5.0, latitude: -30.040181010490798, longitude: -51.21888666132587, operatinhours: ["Segunda - Fechado", "Terça - 18:00 às 23:30", "Quarta - 18:00 às 23:30", "Quinta -  18:00 às 00:00", "Sexta - 18:00 às 00:00", "Sábado - 18:00 às 00:00", "Domingo - 18:00 às 00:00"], endereco: "R. General Lima e Silva, 918 - Centro Histórico, Porto Alegre", regiao: "Cidade Baixa", caracteristicas: ["Estacionamento", "Aceita PET"])
                quentins.recieveAllPhotos(photosToSAVE: ["Quentins1", "Quentins2", "Quentins3"])
                quentins.photoLogoTOSave = "Quentins"
                bares.append(quentins)

                var pedrinho: Bar = Bar(name: "Boteco Pedrini", description: "Nada melhor que vir se divertir com seus amigos ou familiares aqui no Pedrini! 😄", mood: ["Family friendly"], grade: 5.0, latitude: -30.03736053756768, longitude: -51.222716864275185, operatinhours: ["Segunda - 16:00 às 03:00", "Terça - 16:00 às 03:00", "Quarta - 16:00 às 04:00", "Quinta -  16:00 às 04:00", "Sexta - 16:00 às 05:00", "Sábado - 16:00 às 05:00", "Domingo - 16:00 às 03:00"], endereco: "R. Gen. Lima e Silva, 431 - Cidade Baixa, Porto Alegre", regiao: "Cidade Baixa", caracteristicas: ["Estacionamento"])
                pedrinho.recieveAllPhotos(photosToSAVE: ["Pedrini1", "Pedrini2", "Pedrini3"])
                pedrinho.photoLogoTOSave = "Pedrini"
                bares.append(pedrinho)

                var bira: Bar = Bar(name: "Réu Rango e Bira", description: "Muita comilança e muita bira 😋🍻", mood: ["Fofoca", "Barzinho", "Family friendly"], grade: 5.0, latitude: -30.034686004827947, longitude: -51.226779559478764, operatinhours: ["Segunda - Fechado", "Terça - 17:00 às 00:00", "Quarta - 17:00 às 00:00", "Quinta -  17:00 às 00:00", "Sexta - 17:00 às 00:00", "Sábado - 17:00 às 00:00", "Domingo - 17:00 às 00:00"], endereco: "R. Cel. Fernando Machado, 1168 - Centro Histórico, Porto Alegre" , regiao: "Cidade Baixa", caracteristicas: ["Estacionamento"])
                bira.recieveAllPhotos(photosToSAVE: ["RReBira1", "RReBira2", "RReBira3"])
                bira.photoLogoTOSave = "RReBira"
                bares.append(bira)

                var brita: Bar = Bar(name: "Brita", description: "🟠 Um espaço multicultural a céu aberto.", mood: ["Fofoca", "Barzinho", "Esquenta", "Role de casal"], grade: 5.0, latitude: -30.040944420631558, longitude: -51.21833618668556, operatinhours: ["Segunda - Fechado", "Terça - Fechado", "Quarta - 18:00 às 00:00", "Quinta -  18:00 às 00:00", "Sexta - 18:00 às 01:30", "Sábado - 18:00 às 01:30", "Domingo - 17:00 às 00:00"], endereco: "R. Gen. Lima e Silva, 1037 - Centro Histórico, Porto Alegre", regiao: "Cidade Baixa", caracteristicas: ["Estacionamento"])
                brita.recieveAllPhotos(photosToSAVE: ["Brita1", "Brita2", "Brita3"])
                brita.photoLogoTOSave = "Brita"
                bares.append(brita)

                var ceu: Bar = Bar(name: "Céu Bar e Arte", description: "A dona do melhor Caipão do sul do Brasil ✌️", mood: ["Esquenta", "Fofoca", "Barzinho", "Familu friendly"], grade: 5.0, latitude: -30.044803976971046, longitude:  -51.21568220365493, operatinhours: ["Segunda - Fechado", "Terça - 18:00 às 00:00", "Quarta - 18:00 às 00:00", "Quinta -  18:00 às 00:00", "Sexta - 18:00 às 01:00", "Sábado - 18:00 às01:00", "Domingo - 18:00 às 00:00"], endereco: "R. General Lima e Silva, 1487 - Azenha, Porto Alegre", regiao: "", caracteristicas: ["Estacionamento"])
                ceu.recieveAllPhotos(photosToSAVE: ["Ceu1", "Ceu2", "Ceu3"])
                ceu.photoLogoTOSave = "Ceu"
                bares.append(ceu)
                
                var agante: Bar =  Bar(name: "El Aguante", description: "El aguante: Pela cultura democrática de botequim aguante! 👋 Venha curtir uns traguitos, croquetes y conservas!", mood: ["Barzinho", "Fofoca", "Esquenta", "Role de casal"], grade: 5.0, latitude: -30.033459015263357, longitude: -51.20590034783193, operatinhours: ["Segunda - Fechado", "Terça - 17:00 às 23:00", "Quarta - 17:00 às 23:00", "Quinta -  17:00 às 23:00", "Sexta - 16:00 às 23:00", "Sábado - 17:00 às 23:00", "Domingo - Fechado"], endereco: "R. Miguel Tostes, 611 - Rio Branco, Porto Alegre", regiao: "Bom Fim", caracteristicas: ["Estacionamento"])
                agante.recieveAllPhotos(photosToSAVE: ["ElAguante1", "ElAguante2"])
                agante.photoLogoTOSave = "ElAguante"
                bares.append(agante)
                
                var brasco: Bar =  Bar(name: "Espaço Brasco", description: "A sala de estar do Bom Fim ✨", mood: ["Barzinho", "Fofoca", "Family friendly"], grade: 5.0, latitude: -30.0317770480045, longitude: -51.210725417149476, operatinhours: ["Segunda - 07:30 às 22:00", "Terça - 07:30 às 22:00", "Quarta - 07:30 às 22:00", "Quinta -  07:30 às 22:00", "Sexta - 07:30 às 22:00", "Sábado - 07:30 às 22:00", "Domingo - 07:30 às 22:00"], endereco: "Rua Fernandes Vieira, 286 - Bom Fim, Porto Alegre", regiao: "Bom Fim", caracteristicas: ["Estacionamento"])
                brasco.recieveAllPhotos(photosToSAVE: ["EspacoBarasco1", "EspacoBarasco2", "EspacoBarasco3"])
                brasco.photoLogoTOSave = "Brasco"
                bares.append(brasco)
                
                var bibah: Bar = Bar(name: "Bibah", description: "🍹 drinks na calçadinha favorita do Bom Fim 🌈 orgulho o ano inteiro", mood: ["Ambiente temático", "Fofoca"], grade: 5.0, latitude: -30.034102274800194, longitude: -51.21290185947873, operatinhours: ["Segunda - 15:00 às 23:00", "Terça - 15:00 às 23:00", "Quarta - 15:00 às 23:00", "Quinta -  15:00 às 00:00", "Sexta - 15:00 às 00:00", "Sábado - 15:00 às 00:00", "Domingo - 15:00 às 21:00"], endereco: "Rua General João Telles, 531 - Bom Fim, Porto Alegre", regiao: "Bom Fim", caracteristicas: ["Estacionamento"])
                bibah.recieveAllPhotos(photosToSAVE: ["BibahBar1", "BibahBar2", "BibahBar3"])
                bibah.photoLogoTOSave = "Bibah"
                bares.append(bibah)
                
                var armazem: Bar = Bar(name: "Armazem", description: "Um lugar para conhecer uma variedade de bebidas enquanto aproveita o clima da redenção.", mood: ["Barzinho, Fofoca, Family friendly, Esquenta, Role de casal"], grade: 5.0, latitude: -30.03566772494728, longitude: -51.21140817666721, operatinhours: ["Segunda - 18:00 às 23:00", "Terça - 18:00 às 23:00", "Quarta - 18:00 às 23:00", "Quinta -  18:00 às 23:00", "Sexta - 18:00 às 23:00", "Sábado - 18:00 às 23:00", "Domingo - 18:00 às 23:00"], endereco: "Avenida Borges de Medeiros, Viaduto Otávio Rocha, 786 - Centro Histórico, Porto Alegre", regiao: "Cidade Baixa", caracteristicas: ["Estacionamento"])
                armazem.recieveAllPhotos(photosToSAVE: ["Armazem1", "Armazem2", "Armazem3"])
                armazem.photoLogoTOSave = "Armazem"
                bares.append(armazem)
                
                var osvaldo: Bar = Bar(name: "Bar do osvaldo", description: "Venha conhecer o famoso Samba do Osvaldo! 🎶", mood: ["Esquenta", "Role de casal"], grade: 5.0, latitude: -30.033612608086532, longitude: -51.21433027116467, operatinhours: ["Segunda - Fechado", "Terça - 18:00 às 00:00", "Quarta - 18:00 às 00:00", "Quinta -  18:00 às 00:00", "Sexta - 19:00 às 01:00", "Sábado - 19:00 às 01:00", "Domingo - Fechado"], endereco: "Av. Osvaldo Aranha, 784 - Bom Fim, Porto Alegre", regiao: "Bom Fim", caracteristicas: ["Estacionamento"])
                osvaldo.recieveAllPhotos(photosToSAVE: ["Osvaldo1", "Osvaldo2"])
                osvaldo.photoLogoTOSave = "Osvaldo"
                bares.append(osvaldo)
                
                for i in 0..<bares.count{
                    cloud.addBar(bar: bares[i])
                }
            
            }
            label: {
                Text("Mochila Mochila...")
            }
        }
    }
}

struct Profile_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
