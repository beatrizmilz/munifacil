#' Incluir o codigo do IBGE
#'
#' @param data_set base de dados arrumada, com colunas muni_join e uf_join
#' @param tabela_referencia tabela de referência. Por padrão usa uma base interna
#' @param diagnostico imprimir diagnóstico?
#'
#' @export
incluir_codigo_ibge <- function (data_set,
                                 tabela_referencia = munifacil::depara_muni_codigo,
                                 diagnostico = TRUE) {

  resultado <- data_set %>%
    dplyr::left_join(
      tabela_referencia,
      c("muni_join", "uf_join")
    )

  if (diagnostico) {
    diagnostico_join(resultado)
  }

  resultado
}

diagnostico_join <- function(resultado) {

  quantidade_na <- sum(is.na(resultado[["id_municipio"]]))
  pct_na <- scales::percent(mean(is.na(resultado[["id_municipio"]])))

  if (quantidade_na == 0) {
    usethis::ui_done("Uhul! Deu certo!")
  } else {
    usethis::ui_todo("Ainda faltam {quantidade_na} ({pct_na}) casos...")
  }

}
