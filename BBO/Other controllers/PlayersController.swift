//
//  PlayersController.swift
//  BBO
//
//  Created by 楊曜安 on 2024/2/20.
//

import Foundation

class PlayersController {
    enum PlayersControllerError: Error, LocalizedError {
        case batterNotFound
        case lineupNotFound
        case addLineupFailed
        case lineupUpdateFailed
        case deleteLineupFailed
        case updateBatterTeamLineupFailed
    }
    static let shared = PlayersController()
    
    private let baseURL = URL(string: "https://api.airtable.com/v0/app6WEo0oqis5y1Ud/")!
    private let apiToken = "patUXitQ9LoRxPyLj.9e5ba0b328c5d52c2140e7a1e5cac1899f44f1cd66bcaa47ae0be545cf5a3289"
    
    func fetchBatters() async throws -> [Batter] {
        let batterURL = baseURL.appendingPathComponent("Batter")
        
        //排序資料
        var components = URLComponents(url: batterURL, resolvingAgainstBaseURL: true)!
        components.queryItems = [
            URLQueryItem(name: "sort[0][field]", value: "totalValue"),
            URLQueryItem(name: "sort[0][direction]", value: "desc")
        ]
        
        var request = URLRequest(url: components.url!)
        request.httpMethod = "GET"
        request.setValue("Bearer \(apiToken)", forHTTPHeaderField: "Authorization")
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw PlayersControllerError.batterNotFound
        }
        
        let decoder = JSONDecoder()
        let batterResponse = try decoder.decode(BatterResponse.self, from: data)
        
        return batterResponse.records
    }
    
    func fetchTeamLineup() async throws -> [Batter] {
        let TeamLineupURL = baseURL.appendingPathComponent("TeamLineup")
        
        var components = URLComponents(url: TeamLineupURL, resolvingAgainstBaseURL: true)!
        components.queryItems = [
            URLQueryItem(name: "sort[0][field]", value: "createdTime"),
            URLQueryItem(name: "sort[0][direction]", value: "asc")
        ]
        
        var request = URLRequest(url: components.url!)
        request.httpMethod = "GET"
        request.setValue("Bearer \(apiToken)", forHTTPHeaderField: "Authorization")
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw PlayersControllerError.lineupNotFound
        }
        
        let decoder = JSONDecoder()
        let batterResponse = try decoder.decode(BatterResponse.self, from: data)
        
        return batterResponse.records
    }
    
    
    func addTeamLineup(_ batter: Batter) async throws -> Batter {
        let addteamLineupURL = baseURL.appendingPathComponent("TeamLineup")
        var request = URLRequest(url: addteamLineupURL)
        
        request.httpMethod = "POST"
        request.setValue("Bearer \(apiToken)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let encoder = JSONEncoder()
        let jsonData = try? encoder.encode(batter)
        request.httpBody = jsonData
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw PlayersControllerError.addLineupFailed
        }
        
        let decoder = JSONDecoder()
        let batterResponse = try decoder.decode(Batter.self, from: data)
        
        return batterResponse
    }
    
    func updateBatterTeamLineup(_ batterId: String, with batter: Batter) async throws -> Batter {
        let updateBatterTeamLineupURL = baseURL.appendingPathComponent("Batter/\(batterId)")
        var request = URLRequest(url: updateBatterTeamLineupURL)
        
        request.httpMethod = "PATCH"
        request.setValue("Bearer \(apiToken)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let jsonEncoder = JSONEncoder()
        let jsonData = try jsonEncoder.encode(batter)
        request.httpBody = jsonData
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw PlayersControllerError.updateBatterTeamLineupFailed
        }
        
        let decoder = JSONDecoder()
        let batterTeamLineupResponse = try decoder.decode(Batter.self, from: data)
        
        return batterTeamLineupResponse
    }
    
    func updatelevel(_ batterId: String, with batter: Batter) async throws -> Batter {
        let updateTeamLineupURL = baseURL.appendingPathComponent("TeamLineup/\(batterId)")
        var request = URLRequest(url: updateTeamLineupURL)
        
        request.httpMethod = "PATCH"
        request.setValue("Bearer \(apiToken)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let jsonEncoder = JSONEncoder()
        let jsonData = try jsonEncoder.encode(batter)
        request.httpBody = jsonData
        
        let (data , response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw PlayersControllerError.lineupUpdateFailed
        } 
        let decoder = JSONDecoder()
        let teamLineupResponse = try decoder.decode(Batter.self, from: data)
        
        return teamLineupResponse
    }
    
    func deleteTeamLineup(_ batterId: String) async throws -> Bool {
        let deleteTeamLineupURL = baseURL.appendingPathComponent("TeamLineup/\(batterId)")
        var request = URLRequest(url: deleteTeamLineupURL)
        request.httpMethod = "DELETE"
        request.setValue("Bearer \(apiToken)", forHTTPHeaderField: "Authorization")
        
        let (_, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw PlayersControllerError.deleteLineupFailed
        }
        return true
    }
}
