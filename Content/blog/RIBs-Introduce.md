---
title: RIBs Introduce
date: 2022-10-25 14:09
tags: Swift, Architecture, RIBs, Theory
description: Let's study the RIBs made by Uber!
---

Uber에서 만든 RIBs에 대해서 공부해 보겠습니다.

### What is RIBs?

RIBs는 Uber에서 만든 cross-platform Mobile Architecture Framework 입니다.


공식 Github : [RIBs](https://github.com/uber/RIBs)

<img width="100%"  alt="my-option" src="https://github.com/uber/ribs/raw/assets/documentation/ribs.png">
</img>
RIBs는 Router, Interactor, Builder의 약자입니다. 

하나의 RIB은 Router, Interactor, Builder를 필수적으로 구현해야하고 View와 Presenter는 필요에 따라 구성됩니다.

---

### 각각의 역할

**Builder**

- RIBs 의 모든 구성요소를 생성하고 DI를 정의합니다. 즉 Router, Interactor, View, Component를 모두 생성합니다.

**Component**

- 부모 RIB의 Builder가 Component를 통해 자식 RIB의 Builder로 의존성 주입시켜줍니다.

**Router**

- 자식 RIB를 attach, detach하여 RIBs 논리적 트리 구조를 형성합니다.

**Interactor**

- Business logic을 수행하며 Router로 Routing call 그리고 RIBs의 attach와 detach를 요청하거나, Presenter로 Data model를 전달합니다.

**View**

- UI를 담당하는 로직입니다.
- UI Event를 Presenter로 전달하거나 View model을 받아서 UI를 업데이트합니다.

**Presenter**

- Interactor와 View간의 통신을 담당하며,  Business model을 View model을 변환하는 역할로 상태를 가지고 있지 않은 클래스입니다. Presenter를 생략하는 경우 View model 변환의 책임은 View 또는 Interactor가 되어야 합니다.

---

필요에 따라 Presenter와 View가 구성된다의 의미는, VIPER 패턴과 달리 View가 포함되지 않고 비즈니스 로직으로만 구성된 Viewless RIB의 생성이 가능하다는 의미입니다.


### RIBs Tree
<img width="100%"  alt="my-option" src = "https://github.com/uber/ribs/raw/assets/documentation/state.gif"></img>

RIBs는 논리적 트리구조를 형상하여, 부모 RIB와 자식 RIB 간의 통신을 합니다.

RIBs 간의 통신은 Interactor가 담당합니다.

부모와 자식간의 소통은 Observable Stream을 넘겨주어서 데이터를 전달합니다.

자식에서 부모로의 통신은 자식 Interactor에서 부모 Interactor을 Listener 인터페이스로 접근하게 됩니다.


### RIBs LifeCycle
<img width= "60%" alt="my-option" src = "https://img1.daumcdn.net/thumb/R1280x0/?scode=mtistory2&fname=https%3A%2F%2Fblog.kakaocdn.net%2Fdn%2FbpxXeS%2Fbtq2IkXxyk4%2Fpy5OqSBLtz0UUNbkdRAw3k%2Fimg.png"></img>

- RIB의 Life cycle은 RIB이 Attach, Detach되는 상태가 존재합니다.

<img width= "60%" alt="my-option" src = "https://img1.daumcdn.net/thumb/R1280x0/?scode=mtistory2&fname=https%3A%2F%2Fblog.kakaocdn.net%2Fdn%2FbjTQ91%2Fbtq2HH6zXot%2FWLQuM9QXgRkO4nX8E7KAK0%2Fimg.png" ></img>

- Router의 Animation설정이 필요하므로 Router에 Will, did에 관한 라이프사이클을 추가하면 사용하기 편리하게 만들 수 있습니다.


### RIBs의 장단점

#### 장점
- “제대로 된 모듈화가 목적”이지만 VIPER는 그러지 않는 점이 존재
- View의 Tree를 중심적으로 앱이 진행되는 단점, View에 의해 앱 상태가 동작되는 장점 → RIBs의 트리로 보완
- View와 Business tree가 밀접하게 결합되어 있어, UI로직만 포함하거나 business 로직만 포함하는 노드를 구현하기 힘든 점
    - RIBs는 Viewless RIB을 이용해서 Business Logic이 UI Logic에 종속되지 않게 만들 수 있습니다.
    
#### 단점
- Boilerplate: 한 기능에 많은 클래스 수, 하나의 파일에 여러가지 클래스
- Framework 의존성: RIBs라는 한 프레임워크에 프로젝트 전체가 종속


### Template

[공식 Template](https://github.com/uber/RIBs/tree/main/ios/tooling) | [직접 개선한 RIBs Template](https://github.com/JiHoonAHN/Xcode-Template/tree/main/ModernRIBs%20or%20RIBs)
