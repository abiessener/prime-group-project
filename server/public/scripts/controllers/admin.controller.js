myApp.controller('AdminController', ['CsvService', 'AdminService', 'UserService', 'SiteManagerService', '$scope', '$mdDialog', '$mdToast', '$mdSidenav', '$location', function (CsvService, AdminService, UserService, SiteManagerService, $scope, $mdDialog, $mdToast, $mdSidenav, $location) {
  //--------------------------------------
  // -------------VARIABLES----------------
  //--------------------------------------

  const self = this

  // magic numbers for building the year selector
  const START_YEAR = 2010
  const NUM_FUTURE_YEARS = 3

  // get the current year so the select defaults to it
  const now = new Date()
  self.thisYear = now.getFullYear()

  self.yearsArray = []
  self.yearToAdd = self.thisYear
  self.emailYearToAdd = self.thisYear
  self.householdYear = self.thisYear
  self.selectedYear = self.thisYear
  self.validInput = false

  self.questions = CsvService.questions
  self.propertyList = AdminService.propertyList

  self.emails = AdminService.emails
  self.emailSearch = ''
  self.emailYear = self.thisYear
  self.emailOrder = 'email'
  self.emailPageNumber = 1
  self.EMAIL_PAGE_SIZE = 20

  self.selectedSiteManagerProperty = AdminService.selectedSiteManagerProperty
  self.mySiteManagerOrder = 'unit' // default site manager property order

  self.selectedUser = [] // used for the user md-data-table

  self.surveyStatus = AdminService.surveyStatus

  //--------------------------------------
  // -------------FUNCTIONS----------------
  //--------------------------------------

  self.exportVolunteerGiftCards = async () => {
    CsvService.exportVolunteerGiftCards(new Date().getFullYear())
  }

  self.testApiOrder = async () => {
    console.log('testApiOrder')
    try {
      const result = await AdminService.testApiOrder()
      console.log('result', result)
    } catch (err) {
      console.log('error')
    }

    $mdToast.show(
      $mdToast.simple()
        .textContent('Test resolved!')
        .position('top right')
    )
  }

  self.paginateEmails = (page, limit) => {
    self.emailPageNumber = page
    self.searchEmails()
  }

  self.addEmail = () => {
    AdminService.addEmail(self.emailToAdd).then((_response) => {
      self.emailToAdd = ''
      self.searchEmails()
    }).catch((error) => {
      console.error(error)
      $mdToast.show(
        $mdToast.simple()
          .textContent(`Error creating email ${self.emailToAdd}.`)
          .hideDelay(2000)
      )
    })
  }
  
  self.searchEmails = () => {
    AdminService.getEmails({
      searchText: self.emailSearch, 
      year: self.emailYear, 
      pageSize: self.EMAIL_PAGE_SIZE, 
      pageNumber: self.emailPageNumber 
    })
  }

  self.deleteEmail = (emailDto) => {
    AdminService.deleteEmail(emailDto).then((_response) => {
      self.searchEmails()
    }).catch((error) => {
      console.error(error)
      $mdToast.show(
        $mdToast.simple()
          .textContent(`Error deleting email ${emailDto.email}.`)
          .hideDelay(2000)
      )
    })
  }

  self.updateEmail = (emailDto) => {
    AdminService.updateEmail(emailDto)
  }

  // deletes a user out of the db
  self.deleteUser = function (user) {
    const confirm = $mdDialog.confirm()
      .title('Confirm Delete')
      .textContent('Do you really want to delete this user? This cannot be undone!')
      .ariaLabel('delete confirm dialog')
      .targetEvent(event)
      .ok('Delete')
      .cancel('Cancel')

    $mdDialog.show(confirm).then(() => {
      AdminService.deleteUser(user)
    }, () => { }) // blank function is to do nothing when 'cancel' is chosen. otherwise md generates console warnings
  }

  // exports all responses for the chosen year to a csv and starts the download
  self.exportAllResponses = function () {
    CsvService.exportAllResponses(self.yearToAdd)
  }

  self.exportHouseholdResponses = function () {
    CsvService.exportHouseholdResponses(self.yearToAdd)
  }

  self.updatePaperResponse = function (property, year) {
    SiteManagerService.updatePaperResponse(property, year)
      .then((_response) => {
        AdminService.getResponseRate([property.property], year)
      })
  }

  // event handler for 'change' event on file input. reads in the file, and sets the validInput flag to true which shows the upload button
  self.handleFileSelect = function (fileEvent) {
    const reader = new FileReader()
    reader.onerror = function () {
      console.error('reader error')
    }
    reader.onload = function (readerEvent) {
      // this is where the data is ready
      self.validInput = true
      $scope.$apply()
      self.userInput = readerEvent.target.result
    }
    reader.readAsText(fileEvent.target.files[0])
  }

  // authorizes or de-authorizes a user for a particular property
  self.manageAuth = function (user, property, route) {
    AdminService.manageAuth(user.id, property, route)
  }

  // Toggle Sidenav
  self.openLeftMenu = function () {
    $mdSidenav('left').toggle()
  }

  // called by the UPLOAD CSV button, sends the chosen file and the year to the service for POSTing to the server. Hides the upload button to avoid weird double-click errors
  self.startUpload = function () {
    const confirm = $mdDialog.confirm()
      .title('Confirm Upload')
      .textContent('Uploading data will OVERWRITE the selected year\'s occupancy data. Are you sure?')
      .ariaLabel('upload confirm dialog')
      .targetEvent(event)
      .ok('Overwrite')
      .cancel('Cancel')

    $mdDialog.show(confirm).then(() => {
      CsvService.uploadCsv(self.userInput, self.yearToAdd)
      self.validInput = false
    }, () => { })
  }

  self.importEmailCsv = function () {
    const confirm = $mdDialog.confirm()
      .title('Confirm Upload')
      .textContent('Uploading data will add any emails not already present in the system for the selected year. Are you sure?')
      .ariaLabel('upload confirm dialog')
      .targetEvent(event)
      .ok('Import')
      .cancel('Cancel')

    $mdDialog.show(confirm).then(() => {
      CsvService.uploadEmailCsv(self.emailFileInput, self.emailYearToAdd)
      self.validInput = false
    }, () => { })
  }

  self.handleEmailFileSelect = function (fileEvent) {
    const reader = new FileReader()
    reader.onerror = function () {
      console.error('reader error')
    }
    reader.onload = function (readerEvent) {
      // this is where the data is ready
      self.validInput = true
      $scope.$apply()
      self.emailFileInput = readerEvent.target.result
    }
    reader.readAsText(fileEvent.target.files[0])
  }

  // called by a button on each individual question. displays a confirm dialog and if confirmed, updates the question in the db
  self.updateQuestion = function (question) {
    const confirm = $mdDialog.confirm()
      .title('Confirm Update')
      .textContent('Do you really want to update this question? This will affect every survey from now on!')
      .ariaLabel('update confirm dialog')
      .targetEvent(event)
      .ok('Update')
      .cancel('Cancel')

    $mdDialog.show(confirm).then(() => {
      CsvService.updateQuestion(question)
    }, () => { })
  }

  self.getSurveyStatus = async () => {
    await AdminService.getSurveyStatus()
    $scope.$apply()
  }

  self.updateSurveyStatus = async (role, state) => {
    await AdminService.updateSurveyStatus(role, state)
    await AdminService.getSurveyStatus()
    $scope.$apply()
  }

  //--------------------------------------
  // -------------RUNTIME CODE-------------
  //--------------------------------------
  CsvService.getQuestions()
  AdminService.getEmails({ year: new Date().getFullYear(), pageSize: 20, pageNumber: 1 })

  // build yearsArray - this is what's shown in the select. Starts at START_YEAR and ends at that plus NUM_FUTURE_YEARS
  for (let index = START_YEAR; index < (self.thisYear + NUM_FUTURE_YEARS); index += 1) {
    self.yearsArray.push(index)
  }

  // assigns the event listener function self.handleFileSelect()
  // run only if on the /admin route
  self.currentPath = $location.path()
  if (self.currentPath === '/admin') {
    document.getElementById('admin-file-input').addEventListener('change', self.handleFileSelect, false)
    document.getElementById('admin-email-input').addEventListener('change', self.handleEmailFileSelect, false)
  }

  // Gets user information and assign to self.users
  self.AdminService = AdminService
  AdminService.getUsers()
  self.users = AdminService.users

  self.UserService = UserService // connects admin controller to user service
  self.SiteManagerService = SiteManagerService // connects admin controller to site manager service

  self.getSelectedSiteProperty = function (selectedProperty, forYear) {
    AdminService.getSelectedSiteProperty(selectedProperty, forYear)
    AdminService.getResponseRate([selectedProperty], forYear)
  }

  self.responseRate = AdminService.responseRate

  AdminService.getResponseRate()

  if ($location.path === '/admin-survey-toggle') self.getSurveyStatus()
}])
