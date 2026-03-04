from database import Database


class PetAdoptionSystem:
    def __init__(self):
        """Initialize the system and connect to database"""
        self.db = Database()
        self.db.connect()

    # Create Operation

    def add_new_pet(self):
        """Add a new pet to the system"""
        print("\n" + "=" * 50)
        print("🐕 ADD NEW PET")
        print("=" * 50)

        try:
            name = input("Pet name: ")
            age = int(input("Age (0-30): "))
            gender = input("Gender (Male/Female): ")

            # Shows species
            species = self.db.fetch_query("SELECT * FROM Species ORDER BY species_name")
            print("\n📋 Available Species:")
            for s in species:
                print(f"  {s['species_id']}. {s['species_name']}")
            species_id = int(input("Select species ID: "))

            # Shows breeds for selected species
            breeds = self.db.fetch_query(
                "SELECT * FROM Breeds WHERE species_id = %s ORDER BY breed_name",
                (species_id,),
            )
            print("\n📋 Available Breeds:")
            for b in breeds:
                print(f"  {b['breed_id']}. {b['breed_name']}")
            breed_id = int(input("Select breed ID: "))

            # Shows shelters
            shelters = self.db.fetch_query("SELECT * FROM Shelter ORDER BY name")
            print("\n📋 Available Shelters:")
            for sh in shelters:
                print(f"  {sh['shelter_id']}. {sh['name']} - {sh['city']}")
            shelter_id = int(input("Select shelter ID: "))

            # Calls stored procedure sp_add_pet here
            self.db.call_procedure(
                "sp_add_pet", (name, age, gender, species_id, breed_id, shelter_id)
            )
            print(f"\n✅ SUCCESS! Pet '{name}' has been added to the system!")

        except ValueError:
            print("\n❌ Error: Please enter valid numbers for IDs and age!")
        except Exception as e:
            print(f"\n❌ Error adding pet: {e}")

    def add_new_adopter(self):
        """Add a new adopter"""
        print("\n" + "=" * 50)
        print("🙋🏻REGISTER NEW ADOPTER")
        print("=" * 50)

        try:
            name = input("Full name: ")
            email = input("Email: ")
            phone = input("Phone (e.g., 617-555-1234): ")
            city = input("City: ")
            country = input("Country: ") or "USA"  # which is the default country setting in this DB

            self.db.call_procedure(
                "sp_add_adopter", (name, email, phone, city, country)
            )
            print(f"\n✅ SUCCESS! Adopter '{name}' has been registered!")
            print(f"📧 Confirmation will be sent to: {email}")

        except Exception as e:
            print(f"\n❌ Error: {e}")
            if "email" in str(e).lower():
                print("💡 This email might already be registered!")

    def submit_application(self):
        """Submit adoption application"""
        print("\n" + "=" * 50)
        print("📝 SUBMIT ADOPTION APPLICATION")
        print("=" * 50)

        try:
            # First we show available pets using a direct query
            print("\n🐾 Showing available pets...\n")

            pets = self.db.fetch_query(
                """
                SELECT p.pet_id, p.pet_name, p.age, p.gender, 
                       s.species_name, b.breed_name, 
                       sh.name as shelter_name, sh.city
                FROM Pets p
                JOIN Species s ON p.species_id = s.species_id
                JOIN Breeds b ON p.breed_id = b.breed_id
                JOIN Shelter sh ON p.shelter_id = sh.shelter_id
                WHERE p.status = 'Available'
                ORDER BY p.intake_date DESC
            """
            )

            if not pets:
                print("❌ No available pets at the moment.")
                return

            for pet in pets:
                print(
                    f"🐾 ID: {pet['pet_id']:2} | {pet['pet_name']:15} | {pet['species_name']:10} | {pet['breed_name']:20} | Age: {pet['age']}"
                )

            print("\n" + "-" * 50)
            pet_id = int(input("Enter pet ID you want to adopt: "))
            adp_id = int(input("Enter your adopter ID: "))
            notes = input("Why do you want to adopt this pet?: ")

            self.db.call_procedure("sp_submit_application", (pet_id, adp_id, notes))
            print("\n✅ SUCCESS! Your application has been submitted!")
            print("📋 Staff will review your application soon.")

        except ValueError:
            print("\n❌ Error: Please enter valid numbers for IDs!")
        except Exception as e:
            print(f"\n❌ Error: {e}")

    # Read operations for db

    def view_available_pets(self):
        """View all available pets"""
        print("\n" + "=" * 50)
        print("🐾 AVAILABLE PETS FOR ADOPTION")
        print("=" * 50)

        try:
            pets = self.db.fetch_query(
                """
                SELECT p.pet_id, p.pet_name, p.age, p.gender, 
                       s.species_name, b.breed_name, 
                       sh.name as shelter_name, sh.city, p.intake_date
                FROM Pets p
                JOIN Species s ON p.species_id = s.species_id
                JOIN Breeds b ON p.breed_id = b.breed_id
                JOIN Shelter sh ON p.shelter_id = sh.shelter_id
                WHERE p.status = 'Available'
                ORDER BY p.intake_date DESC
            """
            )

            if not pets:
                print("\n❌ No available pets at the moment.")
                return

            for pet in pets:
                print(f"\n{'='*50}")
                print(f"🐾 {pet['pet_name']} (ID: {pet['pet_id']})")
                print(f"   Species: {pet['species_name']}")
                print(f"   Breed: {pet['breed_name']}")
                print(f"   Age: {pet['age']} years old")
                print(f"   Gender: {pet['gender']}")
                print(f"   Location: {pet['shelter_name']}, {pet['city']}")
                print(f"   Available since: {pet['intake_date']}")

            print(f"\n{'='*50}")
            print(f"📊 Total available pets: {len(pets)}")

        except Exception as e:
            print(f"\n❌ Error: {e}")

    def view_all_applications(self):
        """View all adoption applications"""
        print("\n" + "=" * 50)
        print("📋 ALL ADOPTION APPLICATIONS")
        print("=" * 50)

        try:
            apps = self.db.fetch_query(
                """
                SELECT a.app_id, p.pet_name, ad.adp_name, a.app_date, 
                       a.status, s.staff_name as reviewer, a.notes
                FROM Application a
                JOIN Pets p ON a.pet_id = p.pet_id
                JOIN Adopters ad ON a.adp_id = ad.adp_id
                LEFT JOIN Staff s ON a.staff_id = s.staff_id
                ORDER BY a.app_date DESC
            """
            )

            if apps:
                for app in apps:
                    print(f"\n{'='*50}")
                    print(f"📋 Application ID: {app['app_id']}")
                    print(f"   Pet: {app['pet_name']}")
                    print(f"   Adopter: {app['adp_name']}")
                    print(f"   Date: {app['app_date']}")
                    print(f"   Status: {app['status']}")
                    if app["reviewer"]:
                        print(f"   Reviewed by: {app['reviewer']}")
                    if app["notes"]:
                        print(f"   Notes: {app['notes'][:100]}...")
                print(f"\n{'='*50}")
                print(f"📊 Total applications: {len(apps)}")
            else:
                print("\n❌ No applications found.")

        except Exception as e:
            print(f"\n❌ Error: {e}")

    # update operations

    def update_pet_info(self):
        """Update pet information"""
        print("\n" + "=" * 50)
        print("✏️ UPDATE PET INFORMATION")
        print("=" * 50)

        try:
            pet_id = int(input("Enter pet ID to update: "))

            # Show current info
            pet = self.db.fetch_query("SELECT * FROM Pets WHERE pet_id = %s", (pet_id,))

            if not pet:
                print("\n❌ Pet not found!")
                return

            print(f"\n📋 Current Information:")
            print(f"   Name: {pet[0]['pet_name']}")
            print(f"   Age: {pet[0]['age']}")
            print(f"   Shelter ID: {pet[0]['shelter_id']}")
            print(f"\n ↪ Press Enter to keep current value")

            new_name = input(f"New name: ") or pet[0]["pet_name"]
            new_age_input = input(f"New age: ")
            new_age = int(new_age_input) if new_age_input else pet[0]["age"]
            new_shelter_input = input(f"New shelter ID: ")
            new_shelter = (
                int(new_shelter_input) if new_shelter_input else pet[0]["shelter_id"]
            )

            confirm = input(f"\n⚠️ Update pet '{pet[0]['pet_name']}'? (yes/no): ")
            if confirm.lower() == "yes":
                self.db.call_procedure(
                    "sp_update_pet", (pet_id, new_name, new_age, new_shelter)
                )
                print("\n✅ Pet information updated successfully!")
            else:
                print("\n❌ Update cancelled.")

        except ValueError:
            print("\n❌ Error: Please enter valid numbers!")
        except Exception as e:
            print(f"\n❌ Error: {e}")

    def process_application(self):
        """Review and process adoption application"""
        print("\n" + "=" * 50)
        print("⚖️ PROCESS APPLICATION")
        print("=" * 50)

        try:
            # Shows all pending applications
            pending = self.db.fetch_query(
                """
                SELECT a.app_id, p.pet_name, ad.adp_name, a.app_date, a.notes
                FROM Application a
                JOIN Pets p ON a.pet_id = p.pet_id
                JOIN Adopters ad ON a.adp_id = ad.adp_id
                WHERE a.status = 'Pending'
                ORDER BY a.app_date
            """
            )

            if not pending:
                print("\n❌ No pending applications.")
                return

            print("\n📋 Pending Applications:")
            for app in pending:
                print(f"\n  ID: {app['app_id']}")
                print(f"  {app['adp_name']} → {app['pet_name']}")
                print(f"  Date: {app['app_date']}")
                print(f"  Reason: {app['notes'][:80]}...")

            print("\n" + "-" * 50)
            app_id = int(input("Select application ID to process: "))

            print("\nDecision Options:")
            print("  1. Approved")
            print("  2. Rejected")
            decision = input("Enter choice (1 or 2): ")

            status = "Approved" if decision == "1" else "Rejected"

            staff_id = int(input("Your staff ID: "))
            notes = input("Review notes: ")

            confirm = input(f"\n⚠️ {status} application #{app_id}? (yes/no): ")
            if confirm.lower() == "yes":
                self.db.call_procedure(
                    "sp_update_application_status", (app_id, status, staff_id, notes)
                )
                print(f"\n✅ Application {status.lower()} successfully!")
            else:
                print("\n❌ Process cancelled.")

        except ValueError:
            print("\n❌ Error: Please enter valid numbers!")
        except Exception as e:
            print(f"\n❌ Error: {e}")

    def update_adopter_info(self):
        """Update adopter contact information"""
        print("\n" + "=" * 50)
        print("✏️ UPDATE ADOPTER INFORMATION")
        print("=" * 50)

        try:
            adp_id = int(input("Enter adopter ID to update: "))

            # Shows current info of adopters
            adopter = self.db.fetch_query(
                "SELECT * FROM Adopters WHERE adp_id = %s", (adp_id,)
            )

            if not adopter:
                print("\n❌ Adopter not found!")
                return

            print(f"\n📋 Current Information:")
            print(f"   Name: {adopter[0]['adp_name']}")
            print(f"   Email: {adopter[0]['email']}")
            print(f"   Phone: {adopter[0]['phone']}")
            print(f"   City: {adopter[0]['city']}")
            print(f"   Country: {adopter[0]['country']}")
            print(f"\n💡 Press Enter to keep current value")

            new_phone = input(f"New phone: ") or adopter[0]["phone"]
            new_city = input(f"New city: ") or adopter[0]["city"]
            new_country = input(f"New country: ") or adopter[0]["country"]

            confirm = input(
                f"\n⚠️ Update adopter '{adopter[0]['adp_name']}'? (yes/no): "
            )
            if confirm.lower() == "yes":
                self.db.fetch_query(
                    "UPDATE Adopters SET phone = %s, city = %s, country = %s WHERE adp_id = %s",
                    (new_phone, new_city, new_country, adp_id),
                )
                print("\n✅ Adopter information updated successfully!")
            else:
                print("\n❌ Update cancelled.")

        except ValueError:
            print("\n❌ Error: Please enter a valid adopter ID!")
        except Exception as e:
            print(f"\n❌ Error: {e}")

    # Delete operations

    def delete_pet(self):
        """Delete a pet from the system"""
        print("\n" + "=" * 50)
        print("🗑️ DELETE PET")
        print("=" * 50)

        try:
            pet_id = int(input("Enter pet ID to delete: "))

            # Shows pet details
            pet = self.db.fetch_query(
                "SELECT pet_name, status FROM Pets WHERE pet_id = %s", (pet_id,)
            )

            if not pet:
                print("\n❌ Pet not found!")
                return

            print(f"\n⚠️ WARNING: You are about to delete:")
            print(f"   Pet: {pet[0]['pet_name']}")
            print(f"   Status: {pet[0]['status']}")

            confirm = input(f"\nType 'DELETE' to confirm: ")
            if confirm == "DELETE":
                self.db.call_procedure("sp_delete_pet", (pet_id,))
                print("\n✅ Pet deleted successfully!")
            else:
                print("\n❌ Deletion cancelled.")

        except ValueError:
            print("\n❌ Error: Please enter a valid pet ID!")
        except Exception as e:
            print(f"\n❌ Error: {e}")

    def delete_adopter(self):
        """Delete an adopter from the system"""
        print("\n" + "=" * 50)
        print("🗑️ DELETE ADOPTER")
        print("=" * 50)

        try:
            adp_id = int(input("Enter adopter ID to delete: "))

            # Checks for applications
            apps = self.db.fetch_query(
                "SELECT COUNT(*) as count FROM Application WHERE adp_id = %s", (adp_id,)
            )

            if apps and apps[0]["count"] > 0:
                print(
                    f"\n❌ Cannot delete! Adopter has {apps[0]['count']} application(s)!"
                )
                print("💡 Only adopters with no applications can be deleted.")
                return

            # Shows adopter details
            adopter = self.db.fetch_query(
                "SELECT adp_name, email FROM Adopters WHERE adp_id = %s", (adp_id,)
            )

            if not adopter:
                print("\n❌ Adopter not found!")
                return

            print(f"\n⚠️ WARNING: You are about to delete:")
            print(f"   Adopter: {adopter[0]['adp_name']}")
            print(f"   Email: {adopter[0]['email']}")

            confirm = input(f"\nType 'DELETE' to confirm: ")
            if confirm == "DELETE":
                cursor = self.db.connection.cursor()
                cursor.execute("DELETE FROM Adopters WHERE adp_id = %s", (adp_id,))
                self.db.connection.commit()
                print("\n✅ Adopter deleted successfully!")
            else:
                print("\n❌ Deletion cancelled.")

        except ValueError:
            print("\n❌ Error: Please enter a valid adopter ID!")
        except Exception as e:
            print(f"\n❌ Error: {e}")

    def close(self):
        """Close database connection"""
        self.db.disconnect()
