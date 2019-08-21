Locales['en'] = {
    ['document_deleted'] = "Документ был ~g~удален~w~.",
    ['document_delete_failed'] = "Удалить документ ~r~не получилось~w~.",
    ['copy_from_player'] = "Вам ~g~передали форму~w~.",
    ['from_copied_player'] = "Вы передали ~g~форму~w~.",
    ['could_not_copy_form_player'] = "Некому передавать ~r~форму~w~.",
    ['document_options'] = "Документы",
    ['public_documents'] = "Публичные документы",
    ['job_documents'] = "Рабочие докуметы",
    ['saved_documents'] = "Архив",
    ['close_bt'] = "Закрыть",
    ['no_player_found'] = "Человек не найден",
    ['go_back'] = "Назад",
    ['view_bt'] = "Обзор",
    ['show_bt'] = "Показать документ",
    ['give_copy'] = "Сделать копию",
    ['delete_bt'] = "Уничтожить",
    ['yes_delete'] = "Да уничтожить",
}

Config.Documents['en'] = {
      ["public"] = {
        {
          headerTitle = "Доверенность на транспорт",
          headerSubtitle = "Доверенность на пользование транспортным средством.",
          elements = {
            { label = "Номер ТС", type = "input", value = "", can_be_emtpy = false },
            { label = "Имя Фамилия", type = "input", value = "", can_be_emtpy = false },
            { label = "Период", type = "input", value = "", can_be_empty = false },
            { label = "Содержание", type = "textarea", value = "", can_be_emtpy = true },
          }
        },
        -- {
        --   headerTitle = "DEBT STATEMENT TOWARDS CITIZEN",
        --   headerSubtitle = "Official debt statement towards another citizen.",
        --   elements = {
        --     { label = "CREDITOR FIRSTNAME", type = "input", value = "", can_be_emtpy = false },
        --     { label = "CREDITOR LASTNAME", type = "input", value = "", can_be_emtpy = false },
        --     { label = "AMOUNT DUE", type = "input", value = "", can_be_empty = false },
        --     { label = "DUE DATE", type = "input", value = "", can_be_empty = false },
        --     { label = "OTHER INFORMATION", type = "textarea", value = "", can_be_emtpy = true },
        --   }
        -- },
        -- {
        --   headerTitle = "DEBT CLEARANCE DECLARATION",
        --   headerSubtitle = "Declaration of debt clearance from another citizen.",
        --   elements = {
        --     { label = "DEBTOR FIRSTNAME", type = "input", value = "", can_be_emtpy = false },
        --     { label = "DEBTOR LASTNAME", type = "input", value = "", can_be_emtpy = false },
        --     { label = "DEBT AMOUNT", type = "input", value = "", can_be_empty = false },
        --     { label = "OTHERINFORMATION", type = "textarea", value = "I HEREBY DECLARE THAT THE AFOREMENTIONED CITIZEN HAS COMPLETED A PAYMENT WITH THE AFOREMENTIONED DEBT AMOUNT", can_be_emtpy = false, can_be_edited = false },
        --   }
        -- }
      },
      ["police"] = {
        {
          headerTitle = "Заявление",
          headerSubtitle = "Форма",
          elements = {
            { label = "Суть заявления", type = "textarea", value = "", can_be_emtpy = false },
          }
        },
        {
          headerTitle = "Показания свидетеля",
          headerSubtitle = "Официальные показания свидетеля.",
          elements = {
            { label = "Дата события", type = "input", value = "", can_be_emtpy = false },
            { label = "Показания", type = "textarea", value = "", can_be_emtpy = false },
          }
        },
        -- {
        --   headerTitle = "SPECIAL PARKING PERMIT",
        --   headerSubtitle = "Special no-limit parking permit.",
        --   elements = {
        --     { label = "HOLDER FIRSTNAME", type = "input", value = "", can_be_emtpy = false },
        --     { label = "HOLDER LASTNAME", type = "input", value = "", can_be_emtpy = false },
        --     { label = "VALID UNTIL", type = "input", value = "", can_be_empty = false },
        --     { label = "INFORMATION", type = "textarea", value = "THE AFOREMENTIONED CITIZEN HAS BEEN GRANTED UNLIMITED PARKING PERMIT IN EVERY CITY ZONE AND IS VALID UNTIL THE AFOREMENTIONED EXPIRATION DATE.", can_be_emtpy = false },
        --   }
        -- },
        {
          headerTitle = "Разрешение на охоту",
          headerSubtitle = "Разрешение на охоту в округе Блейн.",
          elements = {
            { label = "Имя", type = "input", value = "", can_be_emtpy = false },
            { label = "Фамилия", type = "input", value = "", can_be_emtpy = false },
            { label = "Действительна до", type = "input", value = "", can_be_empty = false },
            { label = "Информация", type = "textarea", value = "", can_be_emtpy = false },
          }
        },
        -- {
        --   headerTitle = "CLEAN CITIZEN CRIMINAL RECORD",
        --   headerSubtitle = "Official clean, general purpose, citizen criminal record.",
        --   elements = {
        --     { label = "CITIZEN FIRSTNAME", type = "input", value = "", can_be_emtpy = false },
        --     { label = "CITIZEN LASTNAME", type = "input", value = "", can_be_emtpy = false },
        --     { label = "VALID UNTIL", type = "input", value = "", can_be_empty = false },
        --     { label = "RECORD", type = "textarea", value = "", can_be_emtpy = false, can_be_edited = false },
        --   }         }
      },
      ["ambulance"] = {
        {
          headerTitle = "Медицинская справка",
          headerSubtitle = "Официальное медицинское заключение.",
          elements = {
            { label = "Имя", type = "input", value = "", can_be_emtpy = false },
            { label = "Фамилия", type = "input", value = "", can_be_emtpy = false },
            { label = "Действительна до", type = "input", value = "", can_be_empty = false },
            { label = "Медицинские записи", type = "textarea", value = "Данный гражданин прошел медицинское освидетельствование. Полностью здоров, паталогий обнаруженно не было.", can_be_emtpy = false },
          }
        },
        {
          headerTitle = "Психологический диагноз",
          headerSubtitle = "Official medical report provided by a psychologist.",
          elements = {
            { label = "INSURED FIRSTNAME", type = "input", value = "", can_be_emtpy = false },
            { label = "INSURED LASTNAME", type = "input", value = "", can_be_emtpy = false },
            { label = "Действительна до", type = "input", value = "", can_be_empty = false },
            { label = "MEDICAL NOTES", type = "textarea", value = " ", can_be_emtpy = false },
          }
        },
        -- {
        --   headerTitle = "MEDICAL REPORT - EYE SPECIALIST",
        --   headerSubtitle = "Official medical report provided by an eye specialist.",
        --   elements = {
        --     { label = "INSURED FIRSTNAME", type = "input", value = "", can_be_emtpy = false },
        --     { label = "INSURED LASTNAME", type = "input", value = "", can_be_emtpy = false },
        --     { label = "VALID UNTIL", type = "input", value = "", can_be_empty = false },
        --     { label = "MEDICAL NOTES", type = "textarea", value = "THE AFOREMENTIONED INSURED CITIZEN WAS TESTED BY A HEALTHCARE OFFICIAL AND DETERMINED WITH A HEALTHY AND ACCURATE EYESIGHT. THIS REPORT IS VALID UNTIL THE AFOREMENTIONED EXPIRATION DATE.", can_be_emtpy = false },
        --   }
        -- },
        {
          headerTitle = "Рецепт на марихуану",
          headerSubtitle = "Рецепт на лечебную марихуану.",
          elements = {
            { label = "Имя", type = "input", value = "", can_be_emtpy = false },
            { label = "Фамилия", type = "input", value = "", can_be_emtpy = false },
            { label = "Действителен доL", type = "input", value = "", can_be_empty = false },
            { label = "Записи", type = "textarea", value = "", can_be_emtpy = false, can_be_edited = false },
          }
        },

      ["avocat"] = {
        {
          headerTitle = "LEGAL SERVICES CONTRACT",
          headerSubtitle = "Legal services contract provided by a lawyer.",
          elements = {
            { label = "CITIZEN FIRSTNAME", type = "input", value = "", can_be_emtpy = false },
            { label = "CITIZEN LASTNAME", type = "input", value = "", can_be_emtpy = false },
            { label = "VALID UNTIL", type = "input", value = "", can_be_empty = false },
            { label = "INFORMATION", type = "textarea", value = "THIS DOCUMENT IS PROOF OF LEGAL REPRESANTATION AND COVERAGE OF THE AFOREMENTIONED CITIZEN. LEGAL SERVICES ARE VALID UNTIL THE AFOREMENTIONED EXPIRATION DATE.", can_be_emtpy = false },
          }
        }
      }
    }
  }
