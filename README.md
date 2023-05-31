**This repo, a labor of love and learning, is a work in progress. You've been warned. [Last updated: Feb. 2023]

journoSEC
=========================

Existing guides and infrastructure for journalists insufficiently prepares them for digitally interacting with sources, working on sensitive stories while protecting sensitive materials offline and online, and traveling cross borders with personal and professional data.

There are myriad good resources for online anonymity,[^1] online privacy,[^2] and circumventing authoritarian regime strangleholds on internet restrictions.[^3] But the job of keeping a secure digital environment is a marathon, not a race,[^4] one which is difficult to maintain while operating in mass media structures reliant on poor digital security infrastructure and loose guidelines for digital health.

Most journalists do not fundamentally understand how networks associate with their technology. [^5] Not for a lack of care or concern. There is simply a choice to be made: get the story, or dawdle learning Linux, coding, and the demands of jobs which often offer only tools distributed by the news or media organization.

Researchers have also concluded similar failings of existing tools for journalists not primarily because of usability and integration issues, but that they actively hinder reporting, most sources dictate how communication is handled, and not least of all financial and timing constraints. [^6]

Attacks on journalists and freedom of the press have increased markedly over the past several
years around the globe.[^7] According to a paper published by the UC Berkely Center for Long-Term Cybersecurity a reason why "journalists do not take sufficient action to protect themselves online is that there is an overwhelming amount of security advice on the internet, most of which is difficult for journalist-readers to understand or translate into practice, and difficult for the authors of the advice to keep up to date." 

The author, Kristen Berdan, continues:

>Most guides do not account for journalists’ busy schedules and time-pressured work cycles. Journalists also operate in an increasingly hostile environment, even in countries with democratic governments and some historical guarantees of freedom of the press and rule of law.

Berdan concludes advice available online "provide[s] no clear path for users to improve their security in a time-efficient way."[^8]

This guide &mdash; which curates and streamlines the myriad viable online sources to focus primarily on use by working investigative journalists, conflict reporters, and war correspondents &mdash; aims to help journalists a) understand their threat model and b) assist in easily integrating security practices into their workflow, despite hurdles presented by company-proffered equipment and systems and c) ultimately hopes to migrate journalists to such software as QubesOS and GrapheneOS for their work while gradually imparting best-practices and a greater understanding of how to mitigate threats (seen and unseen).

This project was originally meant to introduce journalists to QubesOS for their workstations, but grew to understand that (even for myself) my biggest problem was compartmentalizing my work and personal lives. A natural product of using QubesOS is realizing how security in one area may be negated by poor practices elsewhere. Conversely, the steps below make arriving at QubesOS the obvious choice for implementing and maintaining those new practices.

*This guide takes the view that none of these implementation should be ignored and that risk assessments and physical security are never under-served in conflict zones; the internet is just another hostile environment.*

### 🟧 how to use this guide/repository
1. Understand journalist threat models and the partitioning practices outlined in this guide.
2. Evaluates your current practices against the basic, necessary digital security measures listed here. This step introduces basic concepts and helps migrate to easy and simple workflow changes. (Subjects include fieldwork best practices, browser choices, and initial work/personal phone compartmentalization)
3. Furthers implementation what changes you've made in Step. 2 to secure your workstation and devices, encouraging you to introduce new layers of security, trading a few conveniences for greater safety and control. (Subjects include password managers, device encryption, secure communications, VPN, backup and restore practices, and writing software.)
4. Introduces you to resources and software to take full advantage and further streamline what steps you took in 2 and 3. (Subjects include amnesiac operating systems, Tor, DNS, 2FA and keyfobs, GrapheneOS, and further reading.)
5. Configures and migrates workstation/latop to QubesOS.

Please reach out with any questions, comments or suggestions: kenrosen@proton.me (or through any number of other secure channels: https://kennethrrosen.com/secure). Journalists under threat of violence, surveillance or other immediate danger, I will provide free assistance in implementing your threat model mitigations

<b>Remember:</b> you can go as deep into digital and personal security as any internet rabbit hole. Take those steps which allow you to continue you work with a peace of mind, making you more aware of common pitfalls and adversarial tactics, and limit any distractions or obstacles to getting and publishing the story.

### 🟧 sitemap
 - [wiki](https://github.com/kennethrrosen/journoSEC/wiki)
 - [common questions and answers](TKTK)
 - [about the author](https://www.kennethrrosen.com/)
 
 ### 🟧 journoSEC tools
 - [Plausible deniability PAM distress login for QubesOS](https://github.com/kennethrrosen/qubes-PAM-distress-login/)
 - [Qube-builder for journalists and human rights defenders](https://github.com/kennethrrosen/journoSEC/blob/main/qubesOS/journoQUBES.sh)
 - [Custom user-overrides.js for Firefox, based on Arkenfox](https://github.com/kennethrrosen/journoSEC/blob/main/mozilla/arkenfox/user-overrides.js)
 - [Custom user.js for Librewolf](https://github.com/kennethrrosen/journoSEC/blob/main/mozilla/librewolf/LibreWolf.js)
 - [Custom user-overrides.js for Thunderbird](https://github.com/kennethrrosen/journoSEC/blob/main/mozilla/thunderbird/user-overrides.js)
 - [Easy-to-deploy OPNsense home office router firewall](https://github.com/kennethrrosen/journoSEC/blob/main/OPNsense/journoSEC_firewall.sh)

### 🟧 acknowledgments
Literally thousands of sources, mentors, guides, books and my own failures. Many thanks to all.

### 🟧 errata
"Oh?", from my profile bio, is a nod to the moment when a source or story line becomes apparent and an investigation begins.

[^1]: https://anonymousplanet.org/guide.html
[^2]: https://www.privacyguides.org/
[^3]: https://thenewoil.org/
[^4]: https://www.amazon.com/Extreme-Privacy-What-Takes-Disappear/dp/B0898YGR58
[^5]: Quote by Edward Snowden, on Twitter (looking for source)
[^6]: 2015, "Investigating the Computer Security Practices and Needs of Journalists" https://www.franziroesner.com/pdf/journalism-sec15.pdf
[^7]: https://news.un.org/en/story/2020/09/1071492 
[^8]: 2021, "An Evaluation of Online Security Guides for Journalists" https://cltc.berkeley.edu/wp-content/uploads/2021/01/Online_Security_Guides_for_Journalists.pdf
