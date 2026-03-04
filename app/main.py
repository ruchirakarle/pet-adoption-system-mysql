from crud_operations import PetAdoptionSystem
from analytics import Analytics
import sys

def display_menu():
    """Display the main menu"""
    print("\n" + "="*60)
    print("🐾🐶 PET ADOPTION MANAGEMENT SYSTEM 🐰🐾".center(60))
    print("="*60)
    print("\n CREATE OPERATIONS:")
    print("  1. Add New Pet")
    print("  2. Register New Adopter")
    print("  3. Submit Adoption Application")
    print("\n READ OPERATIONS:")
    print("  4. View Available Pets")
    print("  5. View All Applications")
    print("\n UPDATE OPERATIONS:")
    print("  6. Update Pet Information")
    print("  7. Process Application (Approve/Reject)")
    print("  8. Update Adopter Information")
    print("\n DELETE OPERATIONS:")
    print("  9. Delete Pet")
    print(" 10. Delete Adopter")
    print("\n📊 ANALYTICS & REPORTS :")
    print(" 11. Chart: Pets by Species")
    print(" 12. Chart: Shelter Occupancy Rates")
    print(" 13. Chart: Adoption Trends")
    print(" 14. Statistical Analysis Report")
    print("\n  0. Exit System")
    print("="*60)

def main():
    """Main program loop"""
    print("\n" + "="*60)
    print("🐕 WELCOME TO PET ADOPTION SYSTEM 🦜".center(60))
    print("="*60)
    print("\nDeveloped by: Ruchira Ravindra Karle")
    print("Database: MySQL - pet_adoption_system")
    
    # Initialize system
    try:
        system = PetAdoptionSystem()
    except Exception as e:
        print(f"\n Failed to initialize system: {e}")
        print("\n Tips:")
        print("  1. Make sure MySQL is running")
        print("  2. Check your password in app/database.py")
        print("  3. Ensure database 'pet_adoption_system' exists")
        input("\nPress Enter to exit...")
        sys.exit(1)
    
    while True:
        try:
            display_menu()
            choice = input("\n ▶ Enter your choice (0-14): ").strip()
            
            if choice == '1':
                system.add_new_pet()
            elif choice == '2':
                system.add_new_adopter()
            elif choice == '3':
                system.submit_application()
            elif choice == '4':
                system.view_available_pets()
            elif choice == '5':
                system.view_all_applications()
            elif choice == '6':
                system.update_pet_info()
            elif choice == '7':
                system.process_application()
            elif choice == '8':
                system.update_adopter_info()
            elif choice == '9':
                system.delete_pet()
            elif choice == '10':
                system.delete_adopter()
            elif choice == '11':
                analytics = Analytics()
                analytics.chart_pets_by_species()
                analytics.close()
            elif choice == '12':
                analytics = Analytics()
                analytics.chart_shelter_occupancy()
                analytics.close()
            elif choice == '13':
                analytics = Analytics()
                analytics.chart_adoption_trends()
                analytics.close()
            elif choice == '14':
                analytics = Analytics()
                analytics.generate_statistics_report()
                analytics.close()
            elif choice == '0':
                print(" Thank you for using Pet Adoption System!".center(60))
                system.close()
                break
            else:
                print("\n❌ Invalid choice! Please enter a number from 0-14.")
        
        except KeyboardInterrupt:
            print("\n\n⚠️ Program interrupted by user.")
            system.close()
            break
        except Exception as e:
            print(f"\n❌ An unexpected error occurred: {e}")
            print("💡 Returning to main menu...")
        
        input("\n ➤ Press Enter to continue...")

if __name__ == "__main__":
    main()