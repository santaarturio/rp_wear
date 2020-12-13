import Foundation

struct QuestionAndAnswers {
    let question: String
    let answers: [String]
}
class ANQuizVcDataSource: NSObject {
    private let manager = QuizManager()
    private let questionAndAnswers =
    [QuestionAndAnswers(question: "Ты предпочитаешь яркие цвета или монотонные?",
                        answers: ["Яркие", "Монотонные"]),
     QuestionAndAnswers(question: "Какой стиль ты предпочитаешь в одежде?",
                        answers: ["Классика (деловой)", "Кэжуал", "Спортивный"]),
     QuestionAndAnswers(question: "Что для тебя главное?",
                        answers: ["Удобство", "Уникальность", "Красота"]),
     QuestionAndAnswers(question: "Какие принты предпочитаешь?",
                        answers: ["Герои фильмов/мультфильмов", "Абстрактные рисунки", "Что-нибудь уникальное"]),
     QuestionAndAnswers(question: "Тебе хотелось бы принт с изображением твоего любимого мульт. героя?",
                        answers: ["Лиза Симпсон", "Стич", "Грут", "Железный человек", "Гуффи", "Что-нибудь другое"]),
     QuestionAndAnswers(question: "Любишь щепетильную (кропотливую) работу?",
                        answers: ["Нет (легкие)", "Да (тяжелые принты)"])]
    private var userAnswers = [Int]()
    
    //MARK: - Public methods
    //MARK: Get
    public func getNumberOfQuestions() -> Int {
        questionAndAnswers.count
    }
    public func getQuestion(at index: Int) -> String {
        item(at: index)?.question ?? ""
    }
    public func getNumberOfAnswers(byQuestionIndex index: Int) -> Int {
        item(at: index)?.answers.count ?? 0
    }
    public func getAnswer(byQuestionIndex qIndex: Int, at aIndex: Int) -> String {
        let answersCount = item(at: qIndex)?.answers.count ?? 0
        return item(at: qIndex)?.answers[aIndex < answersCount ? aIndex : 0] ?? ""
    }
    public func getResultOfQuiz() -> BagModel {
        userAnswers.count == questionAndAnswers.count ?
            manager.getResult(answers: userAnswers) : BagModel()
    }
    public func currentNumberOfAnswers() -> Int {
        userAnswers.count
    }
    //MARK: Put
    public func insertAnswer(_ answer: Int, at index: Int) {
        index <= userAnswers.count ?
            userAnswers.insert(answer, at: index) : userAnswers.append(answer)
        if userAnswers.count > getNumberOfQuestions() { userAnswers.removeLast() }
    }
    //MARK: Remove
    public func clearAnswers() {
        userAnswers.removeAll()
    }
    //MARK: - Private methods
    private func item(at index: Int) -> QuestionAndAnswers? {
        questionAndAnswers.count > index ? questionAndAnswers[index] : nil
    }

}
