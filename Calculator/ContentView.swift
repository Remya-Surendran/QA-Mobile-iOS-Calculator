import SwiftUI

struct ContentView: View {

    @State private var firstInteger = ""
    @State private var secondInteger = ""
    @State private var result = ""
    @State private var isError = false
    @State private var isQueryInProgress = false

    private let service = Service()

    var body: some View {
        ZStack {
            Color.orange.ignoresSafeArea()
            VStack {
                Text("Calculator App").font(.largeTitle)
                Spacer()
                HStack {
                    TextField("Enter value", text: $firstInteger)
                        .textFieldStyle(.roundedBorder)
                        .accessibilityIdentifier("first_value")
                    TextField("Enter value", text: $secondInteger)
                        .textFieldStyle(.roundedBorder)
                        .accessibilityIdentifier("second_value")
                }.padding()
                Button(action: {
                    self.calculateResult()
                }) {
                    Text("Add")
                        .accessibilityIdentifier("add")
                }
                if isQueryInProgress {
                    ProgressView()
                        .frame(height: 50)
                        .accessibilityIdentifier("progress_view")
                } else {
                    Text(result)
                        .font(.title2)
                        .padding()
                        .frame(height: 50)
                        .background(resultColor())
                        .accessibilityIdentifier("result")
                }
                Spacer()
            }
        }
    }

    func calculateResult() {
        clearResult()
        startQuery()

        service.add(firstString: firstInteger, secondString: secondInteger) { result in

            endQuery()
            switch result {
            case .success(let result):
                clearTextFields()
                self.isError = false
                self.result = result
            case .failure(let error):
                clearTextFields()
                self.isError = true
                self.result = error.description
            }
        }
    }

    func clearTextFields() {
        firstInteger = ""
        secondInteger = ""
    }

    func clearResult() {
        result = ""
        isError = false
    }

    func startQuery() {
        isQueryInProgress = true
    }

    func endQuery() {
        isQueryInProgress = false
    }

    func resultColor() -> Color {
        return isError ? .red : .clear
    }
}

enum ServiceError: Error {
    case emptyFirst
    case emptySecond
    case invalidFirst
    case invalidSecond
    case veryLargeError
    case unknown

    public var description: String {
        switch self {
        case .emptyFirst:
            return "One or more fields are empty"
        case .emptySecond:
            return "One or more fields are empty"
        case .invalidFirst:
            return "Only integers are allowed"
        case .invalidSecond:
            return "Only integers are allowed"
        case .veryLargeError:
            return "Exception overflow error. NSOSStatusErrorDomain Code=-10817 \"(null)\" UserInfo={_LSFunction=_LSSchemaConfigureForStore, ExpectedSimulatorHash={length = 32, bytes = 0xa9298a34 dc614504 8992eb3c f65c237f ... ff5133c6 37c50886 }"
        case .unknown:
            return "Unknown error"
        }
    }
}

class Service {
    func add(firstString: String, secondString: String, completion: @escaping (Result<String, ServiceError>) -> Void) {

        let delay = Int.random(in: 1...3)
        DispatchQueue.main.asyncAfter(deadline: .now() + TimeInterval(delay), execute: {
            guard firstString.count > 0 else {
                completion(.failure(ServiceError.emptyFirst))
                return
            }

            guard secondString.count > 0 else {
                completion(.failure(ServiceError.emptySecond))
                return
            }

            guard let first = Int(firstString) else {
                completion(.failure(ServiceError.invalidFirst))
                return
            }

            guard let second = Int(secondString) else {
                completion(.failure(ServiceError.invalidSecond))
                return
            }

            if first > 1000 || second > 1000 {
                completion(.failure(ServiceError.veryLargeError))
                return
            }

            let result = first + second
            let resultString = String(result)

            completion(.success(resultString))
        })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

