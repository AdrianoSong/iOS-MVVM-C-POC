//
//  Coordinator.swift
//  CoronaMap
//
//  Created by Adriano Song on 4/2/20.
//

import RxSwift

class VCViewModel {

    let bad = DisposeBag()
    let locationManager: LocationManager

    init () {
        locationManager = LocationManager()
    }

    func getAllBrazilCoronaData() -> Observable<Corona> {
         return BaseApi.request(urlConvertile: ApiRouter.getAllBrazilCoronaData)
     }

    func tryToReachLocation(completion: @escaping (_ state: String) -> Void) {
        guard let exposedLocation = self.locationManager.exposedLocation else {
            print("*** Error in \(#function): exposedLocation is nil")
            return
        }

        self.locationManager.getPlace(for: exposedLocation) { placemark in
            guard let placemark = placemark else { return }

            var output = "Our location is:"
            if let country = placemark.country {
                output += "\n\(country)"
            }
            if let state = placemark.administrativeArea {
                output += "\n\(state)"
                completion(state)
            }
            if let town = placemark.locality {
                output += "\n\(town)"
            }
            print("Song location \(output)")
        }
    }

    func screenTitle() -> String {
        return "mapa.brazil.title".localized()
    }

    func screenStateTitle(state: String) -> String {
        return String(format: "mapa.brazil.your_state".localized(), state)
    }

    func screenDescription(timeStamp: String?) -> String {

        guard let dateFull = timeStamp?.toDate(format: .full) else {
            return String(format: "mapa.brazil.last.update".localized(), "N/A")
        }

        return String(format: "mapa.brazil.last.update".localized(),
                      "\(dateFull.string(format: .monthMediumDayYear))")
    }

    func convertInfo<T>(phrase: String, data: T?) -> String {

        guard let data = data else {
            return String(format: phrase, "N/A")
        }

        return String(format: phrase, String(describing: data.self))
    }
}
