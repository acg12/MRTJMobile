//
//  UseCase.swift
//  CrowdControlMRTJ
//
//  Created by Angela Christabel on 13/07/23.
//

import Foundation
import Combine

protocol UseCaseProtocol {
    associatedtype ReturnType
    associatedtype Params: Equatable

    func execute(params: Params) -> AnyPublisher<ReturnType, Failure>
}

struct AnyUseCase<T, P: Equatable>: UseCaseProtocol {

    init<U>(useCase: U) where U: UseCaseProtocol, U.ReturnType == T, U.Params == P {
        proceed = useCase.execute
    }
    func execute(params: P) -> AnyPublisher<T, Failure> {
        proceed(params)
    }

    private let proceed: (P) -> AnyPublisher<T, Failure>

    typealias ReturnType = T
    typealias Params = P


}

extension UseCaseProtocol {
    func eraseToAnyUseCase() -> AnyUseCase<ReturnType, Params> {
        return AnyUseCase<ReturnType, Params>(useCase: self)
    }
}
struct NoParams: Equatable {}
