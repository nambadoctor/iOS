//
//  ServiceProviderAutofillMedicineMapper.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 5/20/21.
//

import Foundation

class ServiceProviderAutofillMedicineMapper {
    static func LocalToGrpc (medicine:Nd_V1_ServiceProviderAutofillMedicineMessage) -> ServiceProviderAutofillMedicine {
        return ServiceProviderAutofillMedicine(AutofillMedicineId: medicine.autofillMedicineID.toString,
                                               Ingredients: medicine.ingredients.toString,
                                               IngredientCount: medicine.ingredientCount.toInt32,
                                               BrandName: medicine.brandName.toString,
                                               RouteOfAdministration: medicine.routeOfAdministration.toString,
                                               DrugType: medicine.drugType.toString)
    }
    
    static func LocalToGrpc (medicines:[Nd_V1_ServiceProviderAutofillMedicineMessage]) -> [ServiceProviderAutofillMedicine] {
        var localMedicines:[ServiceProviderAutofillMedicine] = [ServiceProviderAutofillMedicine]()
        
        for med in medicines {
            localMedicines.append(LocalToGrpc(medicine: med))
        }
        
        return localMedicines
    }
}
