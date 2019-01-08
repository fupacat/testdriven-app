describe('Swagger', () => {

  it('should display the swagger docks correctly', () => {

    cy
      .visit('/')
      .get('.navbar-burger').click()
      .get('a').contains('Swagger').click();

      cy.get('select > option').then((el) => {
        cy.location().then((loc) => {
          expect((el).text()).to.contains(loc.hostname);
        });
      });

  });

});