//
//  CDFavorite+CoreDataProperties.swift
//  NITRIX
//
//  Created by Rostyslav on 31.01.2024.
//

import Foundation
import CoreData

extension CDFavorite {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDFavorite> {
        return NSFetchRequest<CDFavorite>(entityName: "CDFavorite")
    }

    @NSManaged public var id: Int32
    @NSManaged public var image: String?
    @NSManaged public var synopsis: String?
    @NSManaged public var title: String?
}
