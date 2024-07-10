//
//  CoreDataClient.swift
//  TheMovieDB
//
//  Created by alfian on 10/07/24.
//

import CoreData
import Combine

final class CoreDataClient {
  private let container: NSPersistentContainer

  init(container: NSPersistentContainer) {
    self.container = container
    self.loadPersistentStores()
  }

  private func loadPersistentStores() {
    container.loadPersistentStores { _, error in
      if let error = error {
        print("Failed to load persistent stores: \(error.localizedDescription)")
      } else {
        print("Successfully loaded persistent stores")
      }
    }
  }

  func fetchRequest<T: NSManagedObject>(_ type: T.Type, predicate: [String: Any]? = nil) -> AnyPublisher<[T], Error> {
    Future { [weak self] promise in
      guard let self = self else { return }
      Task {
        do {
          let request = NSFetchRequest<T>(entityName: String(describing: type))
          if let predicate = predicate {
            request.predicate = self.createPredicate(from: predicate)
          }
          let result = try self.container.viewContext.fetch(request)
          promise(.success(result))
        } catch {
          promise(.failure(error))
        }
      }
    }
    .eraseToAnyPublisher()
  }

  func add<T: NSManagedObject>(_ type: T.Type, completion: @escaping (NSManagedObjectContext) -> Void) -> AnyPublisher<[T], Error> {
    completion(self.container.viewContext)
    return saveData()
      .flatMap { [weak self] _ in
        self?.fetchRequest(type) ?? Fail(error: NSError(domain: "CoreDataClientError", code: -1, userInfo: nil)).eraseToAnyPublisher()
      }
      .eraseToAnyPublisher()
  }

  private func saveData() -> AnyPublisher<Void, Error> {
    Future { [weak self] promise in
      guard let self = self else { return }
      Task {
        do {
          try self.container.viewContext.save()
          promise(.success(()))
        } catch {
          promise(.failure(error))
        }
      }
    }
    .eraseToAnyPublisher()
  }

  private func createPredicate(from dictionary: [String: Any]) -> NSPredicate {
    var subpredicates = [NSPredicate]()

    for (key, value) in dictionary {
      let subpredicate: NSPredicate
      if let value = value as? String {
          subpredicate = NSPredicate(format: "%K == %@", key, value)
      } else if let value = value as? Int {
          subpredicate = NSPredicate(format: "%K == %d", key, value)
      } else if let value = value as? Double {
          subpredicate = NSPredicate(format: "%K == %f", key, value)
      } else if let value = value as? Bool {
          subpredicate = NSPredicate(format: "%K == %@", key, NSNumber(value: value))
      } else {
          fatalError("Unsupported predicate value type")
      }
      subpredicates.append(subpredicate)
    }

    return NSCompoundPredicate(andPredicateWithSubpredicates: subpredicates)
  }
}
