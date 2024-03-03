//
//  MeetingTeamListFilterFeature.swift
//  weave-ios
//
//  Created by Jisu Kim on 3/3/24.
//

import Foundation
import Services
import ComposableArchitecture

struct MeetingTeamListFilterFeature: Reducer {
    @Dependency(\.dismiss) var dismiss
    
    struct FilterInputs {
        let count: MeetingMemberCountType?
        let regions: MeetingLocationModel?
    }
    
    struct State: Equatable {
        @BindingState var locationList: [MeetingLocationModel]
        var filterModel: MeetingTeamFilterModel
        
        init(
            filterModel: MeetingTeamFilterModel = MeetingTeamFilterModel()
        ) {
            self.locationList = []
            self.filterModel = filterModel
        }
    }
    
    enum Action: BindableAction {
        //MARK: UserAction
        case requestMeetingLocationList
        case fetchMeetingLocationList(list: MeetingLocationListResponseDTO)
        case didTappedSaveButton(input: FilterInputs)
        
        case dismissSaveFilter
        //MARK: Alert Effect
        
        case dismiss
        // bind
        case binding(BindingAction<State>)
    }
    
    var body: some ReducerOf<Self> {
        BindingReducer()
        Reduce { state, action in
            switch action {
            case .requestMeetingLocationList:
                return .run { send in
                    let locationList = try await requestDetailTeamInfo()
                    await send.callAsFunction(.fetchMeetingLocationList(list: locationList))
                }
                
            case .fetchMeetingLocationList(let list):
                state.locationList = list.toDomain
                return .none
                
            case .didTappedSaveButton(let input):
                var filter = state.filterModel
                filter.memberCount = input.count?.countValue
                if let region = input.regions {
                    filter.preferredLocations = [region.name]
                }
                state.filterModel = filter
                return .run { send in
                    await send.callAsFunction(.dismissSaveFilter)
                }
                
            case .dismissSaveFilter:
                return .run { send in
                    await dismiss()
                }
                
            case .dismiss:
                return .run { send in
                    await dismiss()
                }
            default:
                return .none
            }
        }
    }
    
    func requestDetailTeamInfo() async throws -> MeetingLocationListResponseDTO {
        let endPoint = APIEndpoints.getMeetingLocationList()
        let provider = APIProvider()
        let response = try await provider.request(with: endPoint)
        return response
    }
}
