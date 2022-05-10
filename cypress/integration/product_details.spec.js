describe('jungle homepage', () => {
  beforeEach(() => {
    cy.visit('http://localhost:3000/')
  });
  it("Should display the homepage", () => {});

  it("Should redirect to product detail page", () => {
    cy.get("body > main > section > div > article:nth-child(1) > a > img").first().click()
  })
});
