//
//  VersionListViewModel.swift
//  AppStoreCopyApp
//
//  Created by 강지윤 on 2022/03/22.
//

import RxSwift
import RxCocoa
import RxRelay


class VersionListViewModel : ViewModelBuilderProtocol {
    
    struct Input {
    
    }
    
    struct Output {
        let versionSection : Driver<[VersionModelSection]>
    }
    
    struct Builder {
        let appData : AppModel
        let coordinator : VersionListViewCoordinator
    }
    
    let builder : Builder
    let networkAPI : NetworkServiceProtocol
    let disposeBag = DisposeBag()
    
    
    required init(networkAPI: NetworkServiceProtocol = NetworkingAPI.shared, builder: Builder) {
        self.networkAPI = networkAPI
        self.builder = builder
    }
    
    func transform(input: Input) -> Output {
        let versionSection = BehaviorSubject<[VersionModelSection]>(value: [VersionModelSection(name: "버전 기록", items: [VersionModel(version: builder.appData.version, currentVersionReleaseDate: builder.appData.currentVersionReleaseDate, releaseNotes: builder.appData.releaseNotes),VersionModel(version: "1.0.1", currentVersionReleaseDate: "2022-03-31T07:00:00Z", releaseNotes: "2.12.1\n● 사용성 개선 및 안정화\n\n2.12.0 \n● 실험실 추가 기능 오픈 \n - 전체메뉴 탭의 자주 사용하는 서비스를 즐겨찾기 할 수 있어요.\n\n● 입출금 외에도 모든 예적금 통장 사본을 볼 수 있어요.\n● mini 26일저금 현황 공유를 인스타그램 '스토리'  용으로 최적화하였어요."),VersionModel(version: "1.0.1", currentVersionReleaseDate: "2022-03-31T07:00:00Z", releaseNotes: "2.12.1\n● 사용성 개선 및 안정화\n\n2.12.0 \n● 실험실 추가 기능 오픈 \n - 전체메뉴 탭의 자주 사용하는 서비스를 즐겨찾기 할 수 있어요.\n\n● 입출금 외에도 모든 예적금 통장 사본을 볼 수 있어요.\n● mini 26일저금 현황 공유를 인스타그램 '스토리'  용으로 최적화하였어요."),VersionModel(version: "1.0.1", currentVersionReleaseDate: "2022-03-31T07:00:00Z", releaseNotes: "2.12.1\n● 사용성 개선 및 안정화\n\n2.12.0 \n● 실험실 추가 기능 오픈 \n - 전체메뉴 탭의 자주 사용하는 서비스를 즐겨찾기 할 수 있어요.\n\n● 입출금 외에도 모든 예적금 통장 사본을 볼 수 있어요.\n● mini 26일저금 현황 공유를 인스타그램 '스토리'  용으로 최적화하였어요."),VersionModel(version: "1.0.1", currentVersionReleaseDate: "2022-03-31T07:00:00Z", releaseNotes: "2.12.1\n● 사용성 개선 및 안정화\n\n2.12.0 \n● 실험실 추가 기능 오픈 \n - 전체메뉴 탭의 자주 사용하는 서비스를 즐겨찾기 할 수 있어요.\n\n● 입출금 외에도 모든 예적금 통장 사본을 볼 수 있어요.\n● mini 26일저금 현황 공유를 인스타그램 '스토리'  용으로 최적화하였어요."),VersionModel(version: "1.0.1", currentVersionReleaseDate: "2022-03-31T07:00:00Z", releaseNotes: "2.12.1\n● 사용성 개선 및 안정화\n\n2.12.0 \n● 실험실 추가 기능 오픈 \n - 전체메뉴 탭의 자주 사용하는 서비스를 즐겨찾기 할 수 있어요.\n\n● 입출금 외에도 모든 예적금 통장 사본을 볼 수 있어요.\n● mini 26일저금 현황 공유를 인스타그램 '스토리'  용으로 최적화하였어요."),VersionModel(version: "1.0.1", currentVersionReleaseDate: "2022-03-31T07:00:00Z", releaseNotes: "2.12.1\n● 사용성 개선 및 안정화\n\n2.12.0 \n● 실험실 추가 기능 오픈 \n - 전체메뉴 탭의 자주 사용하는 서비스를 즐겨찾기 할 수 있어요.\n\n● 입출금 외에도 모든 예적금 통장 사본을 볼 수 있어요.\n● mini 26일저금 현황 공유를 인스타그램 '스토리'  용으로 최적화하였어요."),VersionModel(version: "1.0.1", currentVersionReleaseDate: "2022-03-31T07:00:00Z", releaseNotes: "2.12.1\n● 사용성 개선 및 안정화\n\n2.12.0 \n● 실험실 추가 기능 오픈 \n - 전체메뉴 탭의 자주 사용하는 서비스를 즐겨찾기 할 수 있어요.\n\n● 입출금 외에도 모든 예적금 통장 사본을 볼 수 있어요.\n● mini 26일저금 현황 공유를 인스타그램 '스토리'  용으로 최적화하였어요."),VersionModel(version: "1.0.1", currentVersionReleaseDate: "2022-03-31T07:00:00Z", releaseNotes: "2.12.1\n● 사용성 개선 및 안정화\n\n2.12.0 \n● 실험실 추가 기능 오픈 \n - 전체메뉴 탭의 자주 사용하는 서비스를 즐겨찾기 할 수 있어요.\n\n● 입출금 외에도 모든 예적금 통장 사본을 볼 수 있어요.\n● mini 26일저금 현황 공유를 인스타그램 '스토리'  용으로 최적화하였어요."),VersionModel(version: "1.0.1", currentVersionReleaseDate: "2022-03-31T07:00:00Z", releaseNotes: "2.12.1\n● 사용성 개선 및 안정화\n\n2.12.0 \n● 실험실 추가 기능 오픈 \n - 전체메뉴 탭의 자주 사용하는 서비스를 즐겨찾기 할 수 있어요.\n\n● 입출금 외에도 모든 예적금 통장 사본을 볼 수 있어요.\n● mini 26일저금 현황 공유를 인스타그램 '스토리'  용으로 최적화하였어요."),VersionModel(version: "1.0.1", currentVersionReleaseDate: "2022-03-31T07:00:00Z", releaseNotes: "2.12.1\n● 사용성 개선 및 안정화\n\n2.12.0 \n● 실험실 추가 기능 오픈 \n - 전체메뉴 탭의 자주 사용하는 서비스를 즐겨찾기 할 수 있어요.\n\n● 입출금 외에도 모든 예적금 통장 사본을 볼 수 있어요.\n● mini 26일저금 현황 공유를 인스타그램 '스토리'  용으로 최적화하였어요."),VersionModel(version: "1.0.1", currentVersionReleaseDate: "2022-03-31T07:00:00Z", releaseNotes: "2.12.1\n● 사용성 개선 및 안정화\n\n2.12.0 \n● 실험실 추가 기능 오픈 \n - 전체메뉴 탭의 자주 사용하는 서비스를 즐겨찾기 할 수 있어요.\n\n● 입출금 외에도 모든 예적금 통장 사본을 볼 수 있어요.\n● mini 26일저금 현황 공유를 인스타그램 '스토리'  용으로 최적화하였어요."),VersionModel(version: "1.0.1", currentVersionReleaseDate: "2022-03-31T07:00:00Z", releaseNotes: "2.12.1\n● 사용성 개선 및 안정화\n\n2.12.0 \n● 실험실 추가 기능 오픈 \n - 전체메뉴 탭의 자주 사용하는 서비스를 즐겨찾기 할 수 있어요.\n\n● 입출금 외에도 모든 예적금 통장 사본을 볼 수 있어요.\n● mini 26일저금 현황 공유를 인스타그램 '스토리'  용으로 최적화하였어요."),VersionModel(version: "1.0.1", currentVersionReleaseDate: "2022-03-31T07:00:00Z", releaseNotes: "2.12.1\n● 사용성 개선 및 안정화\n\n2.12.0 \n● 실험실 추가 기능 오픈 \n - 전체메뉴 탭의 자주 사용하는 서비스를 즐겨찾기 할 수 있어요.\n\n● 입출금 외에도 모든 예적금 통장 사본을 볼 수 있어요.\n● mini 26일저금 현황 공유를 인스타그램 '스토리'  용으로 최적화하였어요."),VersionModel(version: "1.0.1", currentVersionReleaseDate: "2022-03-31T07:00:00Z", releaseNotes: "2.12.1\n● 사용성 개선 및 안정화\n\n2.12.0 \n● 실험실 추가 기능 오픈 \n - 전체메뉴 탭의 자주 사용하는 서비스를 즐겨찾기 할 수 있어요.\n\n● 입출금 외에도 모든 예적금 통장 사본을 볼 수 있어요.\n● mini 26일저금 현황 공유를 인스타그램 '스토리'  용으로 최적화하였어요."),VersionModel(version: "1.0.1", currentVersionReleaseDate: "2022-03-31T07:00:00Z", releaseNotes: "2.12.1\n● 사용성 개선 및 안정화\n\n2.12.0 \n● 실험실 추가 기능 오픈 \n - 전체메뉴 탭의 자주 사용하는 서비스를 즐겨찾기 할 수 있어요.\n\n● 입출금 외에도 모든 예적금 통장 사본을 볼 수 있어요.\n● mini 26일저금 현황 공유를 인스타그램 '스토리'  용으로 최적화하였어요."),VersionModel(version: "1.0.1", currentVersionReleaseDate: "2022-03-31T07:00:00Z", releaseNotes: "2.12.1\n● 사용성 개선 및 안정화\n\n2.12.0 \n● 실험실 추가 기능 오픈 \n - 전체메뉴 탭의 자주 사용하는 서비스를 즐겨찾기 할 수 있어요.\n\n● 입출금 외에도 모든 예적금 통장 사본을 볼 수 있어요.\n● mini 26일저금 현황 공유를 인스타그램 '스토리'  용으로 최적화하였어요."),VersionModel(version: "1.0.1", currentVersionReleaseDate: "2022-03-31T07:00:00Z", releaseNotes: "2.12.1\n● 사용성 개선 및 안정화\n\n2.12.0 \n● 실험실 추가 기능 오픈 \n - 전체메뉴 탭의 자주 사용하는 서비스를 즐겨찾기 할 수 있어요.\n\n● 입출금 외에도 모든 예적금 통장 사본을 볼 수 있어요.\n● mini 26일저금 현황 공유를 인스타그램 '스토리'  용으로 최적화하였어요."),VersionModel(version: "1.0.1", currentVersionReleaseDate: "2022-03-31T07:00:00Z", releaseNotes: "2.12.1\n● 사용성 개선 및 안정화\n\n2.12.0 \n● 실험실 추가 기능 오픈 \n - 전체메뉴 탭의 자주 사용하는 서비스를 즐겨찾기 할 수 있어요.\n\n● 입출금 외에도 모든 예적금 통장 사본을 볼 수 있어요.\n● mini 26일저금 현황 공유를 인스타그램 '스토리'  용으로 최적화하였어요.")])])
        
        
        return .init(
            versionSection : versionSection.asDriverOnErrorNever()
        )
    }
    
}
