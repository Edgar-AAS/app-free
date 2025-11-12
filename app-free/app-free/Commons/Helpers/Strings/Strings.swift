//
//  Strings.swift
//  app-free
//
//  Created by Edgar Arlindo on 02/11/25.
//

import Foundation

//TODO: ADICIONAR TODAS AS STRINGS DO PROJETO AQUI

class Strings {
    private static let tableStringName = "AppFreeStrings"
    
    static var personalAddress: String {
        getStringForKey("Endereço Pessoal")
    }
    
    static var zipCode: String {
        getStringForKey("CEP")
    }
    
    static var address: String {
        getStringForKey("Endereço")
    }
    
    static var number: String {
        getStringForKey("N˚")
    }
    
    static var complement: String {
        getStringForKey("Complemento")
    }
    
    static var neighboor: String {
        getStringForKey("Bairro")
    }
    
    static var state: String {
        getStringForKey("Estado")
    }
    
    static var city: String {
        getStringForKey("Cidade")
    }
    
    static var continueButton: String {
        getStringForKey("CONTINUAR")
    }
    
    static var welcome: String {
        getStringForKey("Bem Vindo!")
    }
    
    static var signUp: String {
        getStringForKey("CADASTRAR")
    }
    
    static var enter: String {
        getStringForKey("ENTRAR")
    }
    
    static var personalData: String {
        getStringForKey("Dados Pessoais")
    }

    static var fullName: String {
        getStringForKey("Nome completo")
    }

    static var birthDate: String {
        getStringForKey("Data de nascimento")
    }

    static var cpf: String {
        getStringForKey("CPF")
    }

    static var email: String {
        getStringForKey("E-mail")
    }

    static var confirmEmail: String {
        getStringForKey("Confirme seu e-mail")
    }

    static var phoneNumberWithAreaCode: String {
        getStringForKey("Número com DD")
    }

    static var termsAndPrivacyAgreement: String {
        getStringForKey("Li e estou de acordo com o Termo de Uso e Política de Privacidade")
    }
    
    static var bankCell: String {
        getStringForKey("BankCell")
    }
    
    static var notFoundBank: String {
        getStringForKey("Nenhum banco encontrado")
    }
    
    static var bankDetailsForPayment: String {
        getStringForKey("Dados Bancários Para Recebimento")
    }

    static var selectOrSearchBank: String {
        getStringForKey("Selecione ou busque um banco")
    }

    static var agencyFourDigits: String {
        getStringForKey("Agência (4 dígitos)")
    }

    static var accountWithDigit: String {
        getStringForKey("Conta com dígito")
    }

    static var accountTypeQuestion: String {
        getStringForKey("Qual é o seu tipo de conta?")
    }

    static var individualPerson: String {
        getStringForKey("Pessoa Física")
    }

    static var legalEntity: String {
        getStringForKey("Pessoa Jurídica")
    }

    static var pixKey: String {
        getStringForKey("Chave PIX")
    }
    
    static var accountType: String {
        getStringForKey("Qual é o seu tipo de conta?")
    }
    
    static var createPassword: String {
        getStringForKey("Crie uma senha")
    }

    static var confirmPassword: String {
        getStringForKey("Confirme sua senha")
    }

    static var finish: String {
        getStringForKey("FINALIZAR")
    }
    
    static var selectStateFirst: String {
        getStringForKey( "Selecione um estado primeiro!")
    }
    
    static var validationError: String {
        getStringForKey("Erro de Validação")
    }
    
    static var navigationNextScene: String {
        getStringForKey("Navegando para a próxima tela")
    }
    
    static var fieldsCompletedSuccessfully: String {
        getStringForKey("Campos preenchidos com sucesso")
    }
    
    static var attetion: String {
        getStringForKey("Atenção")
    }
    
    static var ok: String {
        getStringForKey("OK")
    }
    
    static var invalidZipCode: String {
        getStringForKey("CEP Inválido")
    }
    
    static var somethingWentWrong: String {
        getStringForKey("Algo deu errado")
    }
    
    static var numbers0to9: String {
        getStringForKey("[^0-9]")
    }
    
    static var space: String {
        getStringForKey("empty_string")
    }
    
    static var dashes: String {
        getStringForKey("-")
    }
    
    static var cell: String {
        getStringForKey("cell")
    }
    
    static var fatalError: String {
        getStringForKey("init(coder:) has not been implemented")
    }
    
    static var success: String {
        getStringForKey("Sucesso")
    }
    
    static var successSignUp: String {
        getStringForKey("Cadastro realizado!")
    }
    
    static var error: String {
        getStringForKey("Erro")
    }
    
    static var saveError: String {
        getStringForKey("Falha ao salvar:")
    }
    
    static var passwordCheck: String {
        getStringForKey("As senhas não conferem")
    }
    
    static var invalidPassword: String {
        getStringForKey("Senha inválida")
    }
    
    static var invalidEmail: String {
        getStringForKey("Email inválido")
    }
    
    static var indidualPerson: String {
        getStringForKey("Pessoa Física")
    }
    
    static var bussinessPerson: String {
        getStringForKey("Pessoa Jurídica")
    }
    
    static var pf: String {
        getStringForKey("PF")
    }
    
    static var pj: String {
        getStringForKey("PJ")
    }
    
    static var loadBankError: String {
        getStringForKey("Erro ao carregar bancos. Tente novamente.")
    }
    
    static var loadBankSuccess: String {
        getStringForKey("Dados bancários configurados com sucesso!")
    }
    
    static var upperCaseX: String {
        getStringForKey("X")
    }
    
    static var lowerCaseX: String {
        getStringForKey("x")
    }
    

    static var selectBank: String {
        getStringForKey("Selecione um banco")
    }

    static var agencyRequired: String {
        getStringForKey("Agência obrigatória")
    }

    static var agencyMustHaveFourDigits: String {
        getStringForKey("Agência deve ter 4 dígitos")
    }

    static var accountRequired: String {
        getStringForKey("Conta obrigatória")
    }

    static var invalidAccount: String {
        getStringForKey("Conta inválida (máx. 8 dígitos + dígito verificador numérico ou 'X').")
    }

    static var pixKeyRequired: String {
        getStringForKey("Chave PIX obrigatória")
    }

    static var selfMatches: String {
        getStringForKey("SELF MATCHES %@")
    }
    
    static var bankLabel: String {
        getStringForKey("Banco:")
    }

    static var agencyLabel: String {
        getStringForKey("Agência:")
    }

    static var accountLabel: String {
        getStringForKey("Conta:")
    }

    static var accountTypeLabel: String {
        getStringForKey("Tipo de Conta:")
    }

    static var pixLabel: String {
        getStringForKey("Pix:")
    }
    
    static var noneLabel: String {
        getStringForKey("Nenhum")
    }

    static var skipLine: String {
        getStringForKey("\\n")
    }

    static var bankNotFound: String {
        getStringForKey("Nenhum banco encontrado")
    }

    static var fullNameRequired: String {
        getStringForKey("Nome completo obrigatório.")
    }
    
    static var birthdayRequired: String {
        getStringForKey("Data de nascimento obrigatória.")
    }
    static var ageRequirement: String {
        getStringForKey("Você deve ter pelo menos 18 anos.") }
    
    static var cpfRequired: String {
        getStringForKey("CPF obrigatório.") }
    
    static var cpfInvalid: String {
        getStringForKey("CPF inválido (formato: XXX.XXX.XXX-XX).") }
    
    static var emailRequired: String {
        getStringForKey("E-mail obrigatório.") }
    
    static var emailInvalid: String {
        getStringForKey("E-mail inválido.") }
    
    static var emailConfirmationRequired: String {
        getStringForKey("Confirmação de e-mail obrigatória.") }
    
    static var emailsDoNotMatch: String {
        getStringForKey("Os e-mails não coincidem.") }
    
    static var phoneRequired: String {
        getStringForKey("Número de telefone obrigatório.") }
    
    static var phoneInvalid: String {
        getStringForKey("Número de telefone inválido (formato: (XX) XXXXX-XXXX).") }
    
    static var termsRequired: String {
        getStringForKey("Você deve aceitar os Termos de Uso.")
    }
    
    static var dateFormat: String {
        getStringForKey("dd/MM/yyyy")
    }

    static var cpfRegex: String {
        getStringForKey("^\\d{3}\\.\\d{3}\\.\\d{3}-\\d{2}$")
    }

    static var emailRegex: String {
        getStringForKey("[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}")
    }

    static var phoneRegex: String {
        getStringForKey("^\\(\\d{2}\\) \\d{5}-\\d{4}$")
    }

    static var fullNameInEnglish: String {
        getStringForKey("Full Name")
    }

    static var birthday: String {
        getStringForKey("Birthday")
    }

    static var phone: String {
        getStringForKey("Phone")
    }

     static var formCompleted: String {
        getStringForKey("Formulário preenchido com sucesso! Informações do Usuário:")
    }

    
    
    private static func getStringForKey(_ key: String, args: String...) -> String {
        return String(format: NSLocalizedString(key, tableName: Strings.tableStringName, bundle: Bundle(for: Strings.self), comment: ""), locale: nil, arguments: args)
    }
}
